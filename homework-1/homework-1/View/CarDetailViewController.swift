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
    
    private func getCarInput() -> Car? {
        guard let manufacturer = manufacturerTextField.text,
              let model = modelTextField.text,
              let selectedRow = dropDownView.selectedRow,
              let body = Body.getCase(byId: selectedRow) else {
            let title = "Required fields are empty!"
            let message = "Please fill in the fields:\nManufacturer, Model, Body Type"
            showAlertMessage(title: title, message: message)
            return nil
        }
        
        var yearOfIssue: Int?
        if let yearOfIssueText = yearTextField.text {
            yearOfIssue = Int(yearOfIssueText)
        }
        
        let carNumber = numberTextField.text
        
        let carInput = Car(manufacturer: manufacturer,
                           model: model,
                           body: body,
                           yearOfIssue: yearOfIssue,
                           carNumber: carNumber)
        
        return carInput
    }
    
    // MARK: - Actions
    
    @IBAction func didTapAdd() {
        if let carDetailViewModel = carDetailViewModel,
           let carInput = getCarInput() {
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
    
    @IBAction func didTapEdit() {
        if let carDetailViewModel = carDetailViewModel,
           let carInput = getCarInput() {
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
    
    @IBAction func didTapDelete() {
        if let carDetailViewModel = carDetailViewModel {
            carDetailViewModel.userDeletedCar()
        }
        
        popViewController()
    }
}
