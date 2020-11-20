//
//  CustomLabelBuilder.swift
//  BuilderExample
//
//  Created by Admin on 18.11.2020.
//

import UIKit

protocol ICustomLabelBuilder {
    func setText(_ text: String?) -> Self
    func setTextAlignment(_ textAlignment: NSTextAlignment) -> Self
    func setTextColor(_ textColor: UIColor) -> Self
    
    func setFont(name: String, size: CGFloat?) -> Self
    func setFontSize(_ fontSize: CGFloat) -> Self
    
    func setNumberOfLines(_ numberOfLines: Int) -> Self
    
    func build() -> UILabel
}

extension ICustomLabelBuilder {
    func setFont(name: String) -> Self {
        return setFont(name: name, size: nil)
    }
}

final class CustomLabelBuilder {
    private let label = UILabel()
    
    init(text: String? = nil) {
        label.text = text
    }
}

// MARK: - ICustomLabelBuilder

extension CustomLabelBuilder: ICustomLabelBuilder {
    @discardableResult
    func setText(_ text: String?) -> Self {
        label.text = text
        
        return self
    }
    
    @discardableResult
    func setTextAlignment(_ textAlignment: NSTextAlignment) -> Self {
        label.textAlignment = textAlignment
        
        return self
    }
    
    @discardableResult
    func setTextColor(_ textColor: UIColor) -> Self {
        label.textColor = textColor
        
        return self
    }
    
    @discardableResult
    func setFont(name: String, size: CGFloat? = nil) -> Self {
        let labelSize: CGFloat
        
        if let size = size {
            labelSize = size
        } else {
            labelSize = label.font.pointSize
        }

        label.font = UIFont(name: name, size: labelSize)
        
        return self
    }
    
    @discardableResult
    func setFontSize(_ fontSize: CGFloat) -> Self {
        label.font = label.font.withSize(fontSize)
        
        return self
    }
    
    @discardableResult
    func setNumberOfLines(_ numberOfLines: Int) -> Self {
        label.numberOfLines = numberOfLines
        
        return self
    }
    
    func build() -> UILabel {
        label.sizeToFit()
        
        return label
    }
}
