//
//  CarsViewController.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

import UIKit

class CarsViewController: UIViewController {
    enum CarsTableView {
        static let carCell = "CarCell"
    }
    
    @IBOutlet private weak var dropDownView: DropDownView!
    @IBOutlet private weak var carsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var data: [String] = []
        
        for body in Body.allCases {
            data.append(body.rawValue)
        }
        
        dropDownView.delegate = self
        
        carsTableView.dataSource = self
        carsTableView.delegate = self
        
        dropDownView.configure(data: data, fieldData: "Выберете тип кузова...")
    }
}

// MARK: - UITableViewDataSource

extension CarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carCell = carsTableView.dequeueReusableCell(withIdentifier: CarsTableView.carCell) as! CarCell
        
        return carCell
    }
}

// MARK: - UITableViewDelegate

extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

// MARK: - DropDownViewDelegate

extension CarsViewController: DropDownViewDelegate {
    func dropDownViewDelegate(_ view: DropDownView, itemPressedAt row: Int) {
        print("\(row)")
    }
}
