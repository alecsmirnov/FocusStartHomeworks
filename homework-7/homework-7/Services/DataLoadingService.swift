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
    func dataLoadingService(_ dataLoadingService: DataLoadingService,
                            didCompleteWithError error: DataLoadingError,
                            toURL url: URL)
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

// MARK: - Service

final class DataLoadingService: NSObject {
    typealias LoadingCompletion = (Data) -> Void
    
    // MARK: Properties
    
    weak var delegate: DataLoadingServiceDelegate?
    
    private enum Constants {
        static let sessionIdentifier = "backgroundSession"
    }
    
    private enum AvoidErrorCodes {
        static let canceled = -999
    }
    
    private struct DataLoadingTask {
        var downloadTask: URLSessionDownloadTask?
        var data: Data?
        
        init(downloadTask: URLSessionDownloadTask?) {
            self.downloadTask = downloadTask
        }
    }
    
    private var session: URLSession!
    private var dataLoadingTasks = [URL: DataLoadingTask]()
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        let configuration = URLSessionConfiguration.background(withIdentifier: Constants.sessionIdentifier)
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
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
        } else if let resumeData = dataLoadingTasks[url]?.data {
            downloadTask = session.downloadTask(withResumeData: resumeData)
            dataLoadingTasks[url]?.downloadTask = downloadTask
        }
        
        downloadTask?.resume()
    }
    
    func pause(with urlString: String) {
        guard let url = URL(string: urlString),
              let existedDownloadTask = dataLoadingTasks[url]?.downloadTask else { return }
        
        existedDownloadTask.cancel { self.dataLoadingTasks[url]?.data = $0 }
    }
    
    func cancel(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        dataLoadingTasks[url]?.downloadTask?.cancel()
        dataLoadingTasks[url] = nil
    }
}

// MARK: - URLSessionDownloadDelegate

extension DataLoadingService: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        guard let data = try? Data(contentsOf: location),
              let url = downloadTask.currentRequest?.url else { return }
        
        dataLoadingTasks[url] = nil
        
        DispatchQueue.main.async {
            self.delegate?.dataLoadingService(self, loadData: data, toURL: url)
        }
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        guard let url = downloadTask.originalRequest?.url else { return }

        if totalBytesExpectedToWrite < 0 || bytesWritten == totalBytesExpectedToWrite {
            downloadTask.cancel()
            
            dataLoadingTasks[url] = nil
            
            DispatchQueue.main.async {
                self.delegate?.dataLoadingService(self, didCompleteWithError: .fileNotFound, toURL: url)
            }
        } else {
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
            
            DispatchQueue.main.async {
                self.delegate?.dataLoadingService(self,
                                                  updateLoadingProgress: progress,
                                                  withTotalSize: totalSize,
                                                  toURL: url)
            }
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error as NSError?, error.code != AvoidErrorCodes.canceled else { return }
        
        var url = task.originalRequest?.url
        if url == nil, let urlString = error.userInfo["NSErrorFailingURLStringKey"] as? String {
            url = URL(string: urlString)
        }

        if let url = url {
            dataLoadingTasks[url] = nil
            
            DispatchQueue.main.async {
                self.delegate?.dataLoadingService(self, didCompleteWithError: .invalidURL, toURL: url)
            }
        }
    }
}
