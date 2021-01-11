//
//  ImageLoaderPresenter.swift
//  homework-7
//
//  Created by Admin on 30.11.2020.
//

import Foundation

protocol IImageLoaderPresenter: AnyObject {
    var imagesCount: Int { get }
    
    func didPressPauseButtonAt(index: Int)
    func didPressResumeButtonAt(index: Int)
    func didPressCancelButtonAt(index: Int)
    
    func didPressSearchButton(with text: String)
    
    func deleteRowAt(index: Int)
}

final class ImageLoaderPresenter {
    // MARK: Properties
    
    weak var viewController: IImageLoaderViewController?
    var interactor: IImageLoaderInteractor?
    
    private struct Loading {
        let urlString: String
        var isReceived = false
    }
    
    private var loadings = [Loading]()
}

// MARK: - IImageLoaderPresenter

extension ImageLoaderPresenter: IImageLoaderPresenter {
    var imagesCount: Int {
        return loadings.count
    }
    
    func didPressPauseButtonAt(index: Int) {
        interactor?.pauseLoading(by: loadings[index].urlString)
    }
    
    func didPressResumeButtonAt(index: Int) {
        interactor?.resumeLoading(by: loadings[index].urlString)
    }
    
    func didPressCancelButtonAt(index: Int) {
        interactor?.cancelLoading(by: loadings[index].urlString)
        
        deleteRowAt(index: index)
    }
    
    func didPressSearchButton(with text: String) {
        if !loadings.contains(where: { $0.urlString == text }) {
            loadings.append(Loading(urlString: text))
            
            interactor?.resumeLoading(by: text)
        } else {
            viewController?.showImageExistWarning()
        }
    }
    
    func deleteRowAt(index: Int) {
        loadings.remove(at: index)
        
        viewController?.deleteRow(at: index)
    }
}

// MARK: - IImageLoaderInteractorOutput

extension ImageLoaderPresenter: IImageLoaderInteractorOutput {
    func loadingUpdate(progress: Float, totalSize: String, url: URL) {
        if let index = loadings.firstIndex(where: { $0.urlString == url.absoluteString }) {
            if !loadings[index].isReceived {
                viewController?.insertNewRow()
                
                loadings[index].isReceived = true
            }
            
            viewController?.updateLoadingAt(index: index, with: progress, totalSize: totalSize)
        }
    }
    
    func loadingComplete(data: Data?, error: DataLoadingError?, url: URL) {
        guard let data = data, error == nil,
              let index = loadings.firstIndex(where: { $0.urlString == url.absoluteString }) else {
            switch error {
            case .fileNotFound: viewController?.showImageNotFoundError()
            case .invalidURL: viewController?.showInvalidURLError()
            case .websiteUnavailable: viewController?.showWebsiteUnavailableWarning()
            case .none: break
            }
            
            loadings = loadings.filter { $0.urlString != url.absoluteString }
            
            return
        }

        viewController?.setupImageAt(index: index, with: data)
    }
}
