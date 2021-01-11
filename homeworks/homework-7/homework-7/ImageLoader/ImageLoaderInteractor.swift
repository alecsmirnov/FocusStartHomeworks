//
//  ImageLoaderInteractor.swift
//  homework-7
//
//  Created by Admin on 30.11.2020.
//

import Foundation

protocol IImageLoaderInteractor: AnyObject {
    func resumeLoading(by urlString: String)
    func pauseLoading(by urlString: String)
    func cancelLoading(by urlString: String)
}

protocol IImageLoaderInteractorOutput: AnyObject {
    func loadingUpdate(progress: Float, totalSize: String, url: URL)
    func loadingComplete(data: Data?, error: DataLoadingError?, url: URL)
}

final class ImageLoaderInteractor {
    // MARK: Properties
    
    weak var presenter: IImageLoaderInteractorOutput?
    
    private var dataLoadingService = DataLoadingService()
    
    // MARK: - Initialization
    
    init() {
        dataLoadingService.delegate = self
    }
}

// MARK: - IImageLoaderInteractor

extension ImageLoaderInteractor: IImageLoaderInteractor {
    func resumeLoading(by urlString: String) {
        dataLoadingService.resume(with: urlString)
    }
    
    func pauseLoading(by urlString: String) {
        dataLoadingService.pause(with: urlString)
    }
    
    func cancelLoading(by urlString: String) {
        dataLoadingService.cancel(with: urlString)
    }
}

// MARK: - DataLoadingServiceDelegate

extension ImageLoaderInteractor: DataLoadingServiceDelegate {
    func dataLoadingService(_ dataLoadingService: DataLoadingService, loadData data: Data, toURL url: URL) {
        self.presenter?.loadingComplete(data: data, error: nil, url: url)
    }
    
    func dataLoadingService(_ dataLoadingService: DataLoadingService,
                            updateLoadingProgress progress: Float,
                            withTotalSize size: String,
                            toURL url: URL) {
        self.presenter?.loadingUpdate(progress: progress, totalSize: size, url: url)
    }
    
    func dataLoadingService(_ dataLoadingService: DataLoadingService,
                            didCompleteWithError error: DataLoadingError,
                            toURL url: URL) {
        self.presenter?.loadingComplete(data: nil, error: error, url: url)
    }
}
