//
//  ImageLoaderViewController.swift
//  homework-7
//
//  Created by Admin on 30.11.2020.
//

import UIKit

protocol IImageLoaderViewController: AnyObject {
    func insertNewRow()
    func deleteRow(at index: Int)
    
    func updateLoadingAt(index: Int, with progress: Float, totalSize: String)
    func setupImageAt(index: Int, with data: Data)
    
    func showImageExistWarning()
    func showWebsiteUnavailableWarning()
    func showImageNotFoundError()
    func showInvalidURLError()
}

final class ImageLoaderViewController: UIViewController {
    // MARK: Properties
    
    var presenter: IImageLoaderPresenter?
    
    private var imageLoaderView: ImageLoaderView {
        guard let view = view as? ImageLoaderView else {
            fatalError("view is not a ImageLoaderView instance")
        }
        
        return view
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = ImageLoaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewDelegates()
    }
}

// MARK: - IImageLoaderViewController

extension ImageLoaderViewController: IImageLoaderViewController {
    func insertNewRow() {
        imageLoaderView.insertNewRow()
    }
    
    func deleteRow(at index: Int) {
        imageLoaderView.deleteRow(at: index)
    }
    
    func updateLoadingAt(index: Int, with progress: Float, totalSize: String) {
        if let cell = imageLoaderView.cellForRow(at: index) as? ImageLoaderCell {
            cell.updateLoading(progress: progress, totalSize: totalSize)
        }
    }
    
    func setupImageAt(index: Int, with data: Data) {
        if let cell = imageLoaderView.cellForRow(at: index) as? ImageLoaderCell,
           let image = UIImage(data: data) {
            cell.setImage(image)
            cell.setType(.presentation)
            
            imageLoaderView.beginUpdates()
            imageLoaderView.endUpdates()
        }
    }
    
    func showImageExistWarning() {
        showAlertMessage(title: "Warning", message: "Image with such URL already exists")
    }
    
    func showWebsiteUnavailableWarning() {
        showAlertMessage(title: "Warning", message: "Website unavailable")
    }
    
    func showImageNotFoundError() {
        showAlertMessage(title: "Error", message: "Image not found")
    }
    
    func showInvalidURLError() {
        showAlertMessage(title: "Error", message: "Invalid URL")
    }
}

// MARK: - Private Methods

private extension ImageLoaderViewController {
    func setupViewDelegates() {
        imageLoaderView.delegate = self
        imageLoaderView.tableViewDataSource = self
        imageLoaderView.tableViewDelegate = self
    }
    
    private func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}

// MARK: - ImageLoaderCellDelegate

extension ImageLoaderViewController: ImageLoaderCellDelegate {
    func imageLoaderPauseButtonPressed(_ imageLoaderCell: ImageLoaderCell) {
        if let index = imageLoaderView.indexPath(for: imageLoaderCell)?.row {
            presenter?.didPressPauseButtonAt(index: index)
        }
    }
    
    func imageLoaderResumeButtonPressed(_ imageLoaderCell: ImageLoaderCell) {
        if let index = imageLoaderView.indexPath(for: imageLoaderCell)?.row {
            presenter?.didPressResumeButtonAt(index: index)
        }
    }
    
    func imageLoaderCancelButtonPressed(_ imageLoaderCell: ImageLoaderCell) {
        if let index = imageLoaderView.indexPath(for: imageLoaderCell)?.row {
            presenter?.didPressCancelButtonAt(index: index)
        }
    }
}

// MARK: - ImageLoaderViewDelegate

extension ImageLoaderViewController: ImageLoaderViewDelegate {
    func imageLoaderViewSearchButtonPressed(_ imageLoaderView: ImageLoaderView, text: String) {
        presenter?.didPressSearchButton(with: text)
    }
}

// MARK: - UITableViewDataSource

extension ImageLoaderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.imagesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ImageLoaderCell.reuseIdentifier,
            for: indexPath
        ) as? ImageLoaderCell else { return UITableViewCell() }
        
        cell.setType(.loading)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ImageLoaderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteRowAt(index: indexPath.row)
        }
    }
}

/*
8K:
 
https://images.hdqwalls.com/download/yellow-material-design-abstract-8k-8u-7680x4320.jpg
https://images.hdqwalls.com/download/ocean-sunset-8k-xc-7680x4320.jpg
*/
