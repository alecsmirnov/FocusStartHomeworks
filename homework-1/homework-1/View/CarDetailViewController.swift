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
    
    @IBOutlet private weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var editBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var deleteBarButtonItem: UIBarButtonItem!
    
    @IBOutlet private weak var manufacturerTextField: UITextField!
    @IBOutlet private weak var modelTextField: UITextField!
    @IBOutlet private weak var dropDownView: DropDownView!
    @IBOutlet private weak var yearOfIssueTextField: UITextField!
    @IBOutlet private weak var carNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyMode()
    }
    
    // MARK: - Private Methods
    
    private func applyMode() {
        var fieldData = "Select"
        
        switch carDetailMode {
        case .add:
            setupAddMode()
        case .edit:
            setupEditMode()
            
            if let carDetailViewModel = carDetailViewModel {
                manufacturerTextField.text = carDetailViewModel.manufacturer
                modelTextField.text = carDetailViewModel.model
                yearOfIssueTextField.text = carDetailViewModel.yearOfIssue
                carNumberTextField.text = carDetailViewModel.carNumber
                
                if let body = carDetailViewModel.body {
                    dropDownView.selectedRow = body.rawValue
                    
                    fieldData = body.description
                }
            }
        }
        
        let dropDownData = Body.allCases.map { $0.description }
        
        dropDownView.fontSize = 14
        dropDownView.configure(data: dropDownData, fieldData: fieldData)
    }
    
    private func setupAddMode() {
        addBarButtonItem.title = "Add"
        addBarButtonItem.isEnabled = true
        
        editBarButtonItem.title = ""
        editBarButtonItem.isEnabled = false
        
        deleteBarButtonItem.title = ""
        deleteBarButtonItem.isEnabled = false
    }
    
    private func setupEditMode() {
        addBarButtonItem.title = ""
        addBarButtonItem.isEnabled = false
        
        editBarButtonItem.title = "Edit"
        editBarButtonItem.isEnabled = true
        
        deleteBarButtonItem.title = "Delete"
        deleteBarButtonItem.isEnabled = true
    }
    
    private func popViewController() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true);
        }
    }
    
    private func showAlertMessage(title: String, message: String) {
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

       self.present(alert, animated: true)
   }
    
    private func showMessageBox(message: String, durationTime: Double, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + durationTime) {
            alert.dismiss(animated: true, completion: nil)
            
            completion()
        }
    }
    
    private func getUserInput() -> Car? {
        guard let manufacturer = manufacturerTextField.text,
              let model = modelTextField.text,
              let selectedRow = dropDownView.selectedRow,
              let body = Body(rawValue: selectedRow) else {
            let title = "Required fields are empty!"
            let message = "Please fill in the fields:\nManufacturer, Model, Body Type"
            showAlertMessage(title: title, message: message)
            return nil
        }
        
        var yearOfIssue: Int?
        if let yearOfIssueText = yearOfIssueTextField.text {
            yearOfIssue = Int(yearOfIssueText)
        }
        
        let carNumber = carNumberTextField.text
        
        let carInput = Car(manufacturer: manufacturer,
                           model: model,
                           body: body,
                           yearOfIssue: yearOfIssue,
                           carNumber: carNumber)
        
        return carInput
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapAdd(_ sender: UIBarButtonItem) {
        if let carDetailViewModel = carDetailViewModel,
           let carInput = getUserInput() {
            carDetailViewModel.userAddedCar(manufacturer: carInput.manufacturer,
                                            model: carInput.model,
                                            body: carInput.body,
                                            yearOfIssue: carInput.yearOfIssue,
                                            carNumber: carInput.carNumber)
            
            showMessageBox(message: "New record added successfully", durationTime: 1) {
                self.popViewController()
            }
        }
    }
    
    @IBAction private func didTapEdit(_ sender: UIBarButtonItem) {
        if let carDetailViewModel = carDetailViewModel,
           let carInput = getUserInput() {
            carDetailViewModel.userChangedCar(manufacturer: carInput.manufacturer,
                                              model: carInput.model,
                                              body: carInput.body,
                                              yearOfIssue: carInput.yearOfIssue,
                                              carNumber: carInput.carNumber)
            
            showMessageBox(message: "Record edited successfully", durationTime: 1) {
                self.popViewController()
            }
        }
    }
    
    @IBAction private func didTapDelete(_ sender: UIBarButtonItem) {
        carDetailViewModel?.userDeletedCar()
        
        popViewController()
    }
}
