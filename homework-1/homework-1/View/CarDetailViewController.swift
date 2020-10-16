//
//  CarDetailViewController.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

import UIKit

class CarDetailViewController: UIViewController {
    enum CarDetailMode {
        case add
        case edit
    }
    
    var carDetailViewModel: CarDetailViewModel?
    var carDetailMode = CarDetailMode.add
    
    @IBOutlet private weak var manufacturerTextField: UITextField!
    @IBOutlet private weak var modelTextField: UITextField!
    @IBOutlet private weak var dropDownView: DropDownView!
    @IBOutlet private weak var yearTextField: UITextField!
    @IBOutlet private weak var numberTextField: UITextField!
    
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var fieldData = "Select"
        
        switch carDetailMode {
        case .add:
            setupAddMode()
        case .edit:
            setupEditMode()
            
            if let carDetailViewModel = carDetailViewModel {
                manufacturerTextField.text = carDetailViewModel.manufacturer
                modelTextField.text = carDetailViewModel.model
                yearTextField.text = carDetailViewModel.yearOfIssue
                numberTextField.text = carDetailViewModel.carNumber
                
                if let body = carDetailViewModel.body {
                    dropDownView.selectedRow = body.id
                    
                    fieldData = body.rawValue
                }
            }
        }
        
        var dropDownData: [String] = []
        for body in Body.allCases {
            dropDownData.append(body.rawValue)
        }
        
        dropDownView.fontSize = 14
        dropDownView.configure(data: dropDownData, fieldData: fieldData)
    }
    
    // MARK: - Private Methods
    
    private func setupAddMode() {
        addButton.isHidden = false
        
        editButton.isHidden = true
        deleteButton.isHidden = true
    }
    
    private func setupEditMode() {
        addButton.isHidden = true
        
        editButton.isHidden = false
        deleteButton.isHidden = false
    }
    
    private func popViewController() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true);
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapAdd() {
        guard let manufacturer = manufacturerTextField.text,
              let model = modelTextField.text else {
            return
        }
        
        // TODO: Add validation of required and optional fields
        var yearOfIssue = ""
        var carNumber = ""
        
        if let yearOfIssueText = yearTextField.text {
            yearOfIssue = yearOfIssueText
        }
        
        if let carNumberText = numberTextField.text {
            carNumber = carNumberText
        }
        
        if let carDetailViewModel = carDetailViewModel,
           let selectedRow = dropDownView.selectedRow,
           let body = Body.getCase(byId: selectedRow) {
            carDetailViewModel.userAddedCar(manufacturer: manufacturer,
                                            model: model,
                                            body: body,
                                            yearOfIssue: yearOfIssue,
                                            carNumber: carNumber)
            
            popViewController()
        }
    }
    
    @IBAction func didTapEdit() {
        guard let manufacturer = manufacturerTextField.text,
              let model = modelTextField.text else {
            return
        }
        
        // TODO: Add validation of required and optional fields
        var yearOfIssue = ""
        var carNumber = ""
        
        if let yearOfIssueText = yearTextField.text {
            yearOfIssue = yearOfIssueText
        }
        
        if let carNumberText = numberTextField.text {
            carNumber = carNumberText
        }
        
        if let carDetailViewModel = carDetailViewModel,
           let selectedRow = dropDownView.selectedRow,
           let body = Body.getCase(byId: selectedRow) {
            carDetailViewModel.userChangedCar(manufacturer: manufacturer,
                                              model: model,
                                              body: body,
                                              yearOfIssue: yearOfIssue,
                                              carNumber: carNumber)
            
            popViewController()
        }
    }
    
    @IBAction func didTapDelete() {
        if let carDetailViewModel = carDetailViewModel {
            carDetailViewModel.userDeletedCar()
        }
        
        popViewController()
    }
}
