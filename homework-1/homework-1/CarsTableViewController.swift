//
//  CarsTableViewController.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

import UIKit

class CarsViewController: UIViewController {
    @IBOutlet weak var dropDownView: DropDownView!
    @IBOutlet weak var carsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var data: [String] = []
        
        for body in Body.allCases {
            data.append(body.rawValue)
        }
        
        dropDownView.delegate = self
        
        dropDownView.configure(data: data, fieldData: "Select item...")
    }
}

extension CarsViewController: UITableViewDelegate {
    
}

// MARK: - DropDownViewDelegate

extension CarsViewController: DropDownViewDelegate {
    func dropDownViewDelegate(_ view: DropDownView, itemPressedAt row: Int) {
        print("\(row)")
    }
}
