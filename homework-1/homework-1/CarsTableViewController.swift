//
//  CarsTableViewController.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

import UIKit

class CarsTableViewController: UIViewController {
    @IBOutlet weak var dropDownView: DropDownView!
    
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

// MARK: - DropDownViewDelegate

extension CarsTableViewController: DropDownViewDelegate {
    func dropDownViewDelegate(_ view: DropDownView, itemPressedAt row: Int) {
        print("\(row)")
    }
}
