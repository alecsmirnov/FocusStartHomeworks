//
//  CustomTextViewBuilder.swift
//  BuilderExample
//
//  Created by Admin on 18.11.2020.
//

import UIKit

protocol ICustomTextViewBuilder {
    func setText(_ text: String?) -> Self
    func setTextAlignment(_ textAlignment: NSTextAlignment) -> Self
    func setTextColor(_ textColor: UIColor) -> Self
    
    func setFont(name: String, size: CGFloat?) -> Self
    func setFontSize(_ fontSize: CGFloat) -> Self
    
    func setEditable(_ editable: Bool) -> Self
    
    func build() -> UITextView
}

final class CustomTextViewBuilder {
    private let textView = UITextView()
}

// MARK: - ICustomTextViewBuilder

extension CustomTextViewBuilder: ICustomTextViewBuilder {
    func setText(_ text: String?) -> Self {
        textView.text = text
        
        return self
    }
    
    func setTextAlignment(_ textAlignment: NSTextAlignment) -> Self {
        textView.textAlignment = textAlignment
        
        return self
    }
    
    func setTextColor(_ textColor: UIColor) -> Self {
        textView.textColor = textColor
        
        return self
    }
    
    func setFont(name: String, size: CGFloat?) -> Self {
        var textViewFont: UIFont?
        
        if let size = size {
            textViewFont = UIFont(name: name, size: size)
        } else if let size = textView.font?.pointSize {
            textViewFont = UIFont(name: name, size: size)
        }
        
        textView.font = textViewFont
        
        return self
    }
    
    func setFontSize(_ fontSize: CGFloat) -> Self {
        textView.font = textView.font?.withSize(fontSize)
        
        return self
    }
    
    func setEditable(_ editable: Bool) -> Self {
        textView.isEditable = editable
        
        return self
    }
    
    func build() -> UITextView {
        textView.sizeToFit()
        textView.isScrollEnabled = false
        
        return textView
    }
}
