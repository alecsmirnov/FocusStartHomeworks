//
//  DataLoadingService.swift
//  homework-7
//
//  Created by Admin on 30.11.2020.
//

import Foundation

protocol DataLoadingServiceDelegate: AnyObject {
    func dataLoadingService(_ dataLoadingService: DataLoadingService, loadData data: Data, toURL url: URL)
    func dataLoadingService(_ dataLoadingService: DataLoadingService,
                            updateLoadingProgress progress: Float,
                            withTotalSize size: String,
                            toURL url: URL)
    func dataLoadingService(_ dataLoadingService: DataLoadingService, didCompleteWithError error: DataLoadingError)
}

// MARK: - Error Type

enum DataLoadingError: Error {
    case invalidURL
    case fileNotFound
}

extension DataLoadingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL address", comment: "")
        case .fileNotFound:
            return NSLocalizedString("File not found or does not exist", comment: "")
        }
    }
}

// MARK: - Private Entity

fileprivate struct DataLoadingTask {
    var downloadTask: URLSessionDownloadTask?
    var data: Data?
    
    init(downloadTask: URLSessionDownloadTask?) {
        self.downloadTask = downloadTask
    }
}

// MARK: - Service

final class DataLoadingService: NSObject {
    typealias LoadingCompletion = (Data) -> Void
    
    // MARK: Properties
    
    weak var delegate: DataLoadingServiceDelegate?
    
    private enum Constants {
        static let canceledErrorCode = -999
    }
    
    private var session: URLSession!
    private var dataLoadingTasks = [URL: DataLoadingTask]()
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }
}

// MARK: - Public Methods

extension DataLoadingService {
    func resume(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        var downloadTask: URLSessionDownloadTask?
        
        if dataLoadingTasks[url] == nil {
            downloadTask = session.downloadTask(with: url)
            
            dataLoadingTasks[url] = DataLoadingTask(downloadTask: downloadTask)
        } else if var existedDataLoadingTask = dataLoadingTasks[url],
                  let resumeData = existedDataLoadingTask.data {
            downloadTask = session.downloadTask(withResumeData: resumeData)
            
            existedDataLoadingTask.downloadTask = downloadTask
        }
        
        downloadTask?.resume()
    }
    
    func pause(with urlString: String) {
        guard let url = URL(string: urlString),
              var existedDataLoadingTask = dataLoadingTasks[url],
              let existedDownloadTask = existedDataLoadingTask.downloadTask else { return }
        
        existedDownloadTask.cancel { existedDataLoadingTask.data = $0 }
    }
    
    func cancel(with urlString: String) {
        guard let url = URL(string: urlString),
              var existedDataLoadingTask = dataLoadingTasks[url] else { return }
        
        existedDataLoadingTask.downloadTask?.cancel()
        existedDataLoadingTask.downloadTask = nil
    }
}

// MARK: - URLSessionDownloadDelegate

extension DataLoadingService: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        guard let data = try? Data(contentsOf: location),
              let url = downloadTask.currentRequest?.url else { return }
        
        dataLoadingTasks[location]?.downloadTask = nil
        delegate?.dataLoadingService(self, loadData: data, toURL: url)
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        guard let url = downloadTask.currentRequest?.url else { return }
        
        if totalBytesExpectedToWrite < 0 {
            downloadTask.cancel()
            
            delegate?.dataLoadingService(self, didCompleteWithError: .fileNotFound)
        } else {
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
            
            delegate?.dataLoadingService(self, updateLoadingProgress: progress, withTotalSize: totalSize, toURL: url)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error as NSError?, error.code != Constants.canceledErrorCode {
            delegate?.dataLoadingService(self, didCompleteWithError: .invalidURL)
        }
    }
}
