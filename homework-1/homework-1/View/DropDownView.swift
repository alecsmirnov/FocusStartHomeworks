//
//  DropDownView.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

import UIKit

private enum Settings {
    static let imageLeftEdgeSize: CGFloat = 10
    static let fieldBorderAlpha: CGFloat = 0.12
    static let fieldBorderWidth: CGFloat = 1
}

class DropDownView: UIStackView {
    weak var delegate: DropDownViewDelegate?
    
    var fieldData: String = "" {
        didSet {
            fieldButton.setTitle(fieldData, for: .normal)
        }
    }
    
    var rowCornerRadius: CGFloat = 15
    var rowSpacing: CGFloat = 3
    var itemHeight: CGFloat = 30
    var fontSize:CGFloat = 17
    
    var isClosed = true
    var selectedRow: Int?
    
    private var fieldButton = UIButton()
    private var rowButtons: [UIButton] = []
    
    func configure(data: [String], fieldData: String = "") {
        setupForm()
        
        setupFieldButton(fieldData: fieldData)
        setupRowButtons(data: data)
    }
    
    deinit {
        fieldButton.removeFromSuperview()
        rowButtons.forEach { $0.removeFromSuperview() }
        
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
        fieldButton.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        
        fieldButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        fieldButton.semanticContentAttribute = .forceRightToLeft
        fieldButton.imageEdgeInsets = UIEdgeInsets(top: .zero, left: Settings.imageLeftEdgeSize, bottom: .zero, right: .zero)
        
        fieldButton.layer.borderWidth = Settings.fieldBorderWidth
        fieldButton.layer.borderColor = UIColor.black.withAlphaComponent(Settings.fieldBorderAlpha).cgColor
        fieldButton.layer.cornerRadius = rowCornerRadius
        fieldButton.setTitleColor(.black, for: .normal)
        
        if let titleLabel = fieldButton.titleLabel {
            titleLabel.font = UIFont.systemFont(ofSize: fontSize)
        }
        
        fieldButton.addTarget(self, action: #selector(didFieldPressed), for: .touchUpInside)
        
        addArrangedSubview(fieldButton)
    }
    
    private func setupRowButtons(data: [String]) {
        for (tag, rowTitle) in data.enumerated() {
            let rowButton = UIButton()
            
            rowButton.translatesAutoresizingMaskIntoConstraints = false
            rowButton.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
            
            rowButton.setTitle(rowTitle, for: .normal)
            rowButton.backgroundColor = UIColor.systemBlue
            rowButton.layer.cornerRadius = rowCornerRadius
            
            if let titleLabel = rowButton.titleLabel {
                titleLabel.font = UIFont.systemFont(ofSize: fontSize)
            }
            
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
        
        let row = sender.tag
        
        selectedRow = row
        
        if let delegate = delegate {
            delegate.dropDownViewDelegate(self, itemPressedAt: row)
        }
        
        switchMenu()
    }
}
