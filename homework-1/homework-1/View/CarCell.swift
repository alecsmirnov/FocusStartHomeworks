//
//  CarCell.swift
//  homework-1
//
//  Created by Admin on 16.10.2020.
//

import UIKit

class CarCell: UITableViewCell {
    var carCellViewModel: CarCellViewModel! {
        didSet {
            manufacturerLabel.text = carCellViewModel.manufacturer
            modelLabel.text = carCellViewModel.model
            bodyLabel.text = carCellViewModel.body
            yearOfIssueLabel.text = carCellViewModel.yearOfIssue
        }
    }
    
    @IBOutlet private weak var manufacturerLabel: UILabel!
    @IBOutlet private weak var modelLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var yearOfIssueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
