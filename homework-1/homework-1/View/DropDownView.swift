//
//  DropDownView.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

import UIKit

class DropDownView: UIStackView {
    weak var delegate: DropDownViewDelegate?
    
    var rowCornerRadius: CGFloat = 15.0
    var rowSpacing:      CGFloat = 3.0
    var isClosed = true
    
    var fieldData: String = "" {
        didSet {
            fieldButton.setTitle(fieldData, for: .normal)
        }
    }
    
    private var fieldButton = UIButton()
    private var rowButtons: [UIButton] = []
    
    func configure(data: [String], fieldData: String = "") {
        setupForm()
        
        setupFieldButton(fieldData: fieldData)
        setupRowButtons(data: data)
    }
    
    deinit {
        fieldButton.removeFromSuperview()
        
       rowButtons.forEach { button in
            button.removeFromSuperview()
        }
        
        rowButtons.removeAll()
    }
    
    // MARK: - Private Methods
    
    private func setupForm() {
        alignment = .fill
        distribution = .fillEqually
        spacing = rowSpacing
    }
    
    private func setupFieldButton(fieldData: String) {
        self.fieldData = fieldData
        
        fieldButton.translatesAutoresizingMaskIntoConstraints = false
        fieldButton.backgroundColor = UIColor.systemGray
        fieldButton.layer.cornerRadius = rowCornerRadius
        
        fieldButton.addTarget(self, action: #selector(didFieldPressed), for: .touchUpInside)
        
        addArrangedSubview(fieldButton)
    }
    
    private func setupRowButtons(data: [String]) {
        for (tag, rowTitle) in data.enumerated() {
            let rowButton = UIButton()
            
            rowButton.translatesAutoresizingMaskIntoConstraints = false
            rowButton.setTitle(rowTitle, for: .normal)
            rowButton.backgroundColor = UIColor.systemBlue
            rowButton.layer.cornerRadius = rowCornerRadius
            
            rowButton.isHidden = isClosed
            rowButton.alpha = 0
            
            rowButton.tag = tag
            rowButton.addTarget(self, action: #selector(didRowPressed), for: .touchUpInside)
            
            rowButtons.append(rowButton)
            
            addArrangedSubview(rowButton)
        }
    }
    
    private func switchMenu() {
        isClosed = !isClosed

        rowButtons.forEach { rowButton in
            UIView.animate(withDuration: 0.3) {
                rowButton.isHidden = self.isClosed
                rowButton.alpha = rowButton.alpha == 0 ? 1 : 0
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func didFieldPressed() {
        switchMenu()
    }
    
    @objc private func didRowPressed(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            fieldData = title
        }
        
        if let delegate = delegate {
            let row = sender.tag
            
            delegate.dropDownViewDelegate(self, itemPressedAt: row)
        }
        
        switchMenu()
    }
}
