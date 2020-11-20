//
//  CustomButtonBuilder.swift
//  BuilderExample
//
//  Created by Admin on 18.11.2020.
//

import UIKit

protocol ICustomButtonBuilder: AnyObject {
    func setTitle(_ title: String?, for state: UIControl.State) -> Self
    func setCornerRadius(_ cornerRadius: CGFloat) -> Self
    func setBorderWidth(_ borderWidth: CGFloat) -> Self
    
    func addTarget(_ target: Any?, action: Selector, for event: UIControl.Event) -> Self
    
    func setTitleColor(_ color: UIColor?, for state: UIControl.State) -> Self
    func setBackgroundColor(_ color: UIColor?) -> Self
    func setBorderColor(_ borderColor: UIColor?) -> Self
 
    func build() -> UIButton
}

final class CustomButtonBuilder {
    private let button: UIButton
    
    init(type: UIButton.ButtonType = .system) {
        button = UIButton(type: type)
    }
}

// MARK: - ICustomButtonBuilder
 
extension CustomButtonBuilder: ICustomButtonBuilder {
    @discardableResult
    func setTitle(_ title: String?, for state: UIControl.State) -> Self {
        button.setTitle(title, for: state)
        
        return self
    }
    
    @discardableResult
    func setCornerRadius(_ cornerRadius: CGFloat) -> Self {
        button.layer.cornerRadius = cornerRadius
        
        return self
    }
    
    @discardableResult
    func setBorderWidth(_ borderWidth: CGFloat) -> Self {
        button.layer.borderWidth = borderWidth
        
        return self
    }
    
    @discardableResult
    func addTarget(_ target: Any?, action: Selector, for event: UIControl.Event) -> Self {
        button.addTarget(target, action: action, for: event)
        
        return self
    }
    
    @discardableResult
    func setTitleColor(_ color: UIColor?, for state: UIControl.State) -> Self {
        button.setTitleColor(color, for: state)
        
        return self
    }
    
    @discardableResult
    func setBackgroundColor(_ color: UIColor?) -> Self {
        button.backgroundColor = color
        
        return self
    }
    
    @discardableResult
    func setBorderColor(_ borderColor: UIColor?) -> Self {
        button.layer.borderColor = borderColor?.cgColor
        
        return self
    }
    
    func build() -> UIButton {
        return button
    }
}
