//
//  FavoriteViewController.swift
//  ObserverExample
//
//  Created by Admin on 19.11.2020.
//

import UIKit

final class FavoriteViewController: UIViewController {
    // MARK: Properties
    
    var subject: Subject?
    
    private var favoriteView: FavoriteView {
        guard let view = view as? FavoriteView else {
            fatalError("view is not a SecondView instance")
        }
        
        return view
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = FavoriteView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
        setupViewActions()
    }
}

// MARK: - Subject

private extension FavoriteViewController {
    func addObserver() {
        subject?.append(observer: favoriteView)
    }
}

// MARK: - Actions

private extension FavoriteViewController {
    func setupViewActions() {
        favoriteView.favoriteButtonAction = { [weak self] in
            guard let self = self else { return }
            
            self.subject?.notifyObservers(excluding: self.favoriteView)
        }
    }
}
