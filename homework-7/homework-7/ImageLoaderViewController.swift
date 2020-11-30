//
//  ImageLoaderViewController.swift
//  homework-7
//
//  Created by Admin on 30.11.2020.
//

import UIKit

final class ImageLoaderViewController: UIViewController {
    // MARK: Properties
    
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
    }
}

private extension ImageLoaderViewController {
    func setupViewAction() {
        
    }
}
