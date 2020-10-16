//
//  CarDetailViewController.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

import UIKit

class CarDetailViewController: UIViewController {
    var carDetailViewModel: CarDetailViewModel?
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private Methods
    
    private func setupEditMode() {
        
    }
    
    private func setupAddMode() {
        
    }
    
    private func popViewController() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true);
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapAdd() {
        if let carDetailViewModel = carDetailViewModel {
            carDetailViewModel.userAddedCar(manufacturer: "add test", model: "add test", body: .cabriolet, yearOfIssue: "test", carNumber: "test")
        }
        
        popViewController()
    }
    
    @IBAction func didTapEdit() {
        if let carDetailViewModel = carDetailViewModel {
            carDetailViewModel.userChangedCar(manufacturer: "add test", model: "add test", body: .cabriolet, yearOfIssue: "test", carNumber: "test")
        }
        
        popViewController()
    }
    
    @IBAction func didTapDelete() {
        if let carDetailViewModel = carDetailViewModel {
            carDetailViewModel.userDeletedCar()
        }
        
        popViewController()
    }
}
