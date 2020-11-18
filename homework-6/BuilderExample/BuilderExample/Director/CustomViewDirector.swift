//
//  CustomViewDirector.swift
//  BuilderExample
//
//  Created by Admin on 18.11.2020.
//

import UIKit

final class CustomViewDirector {
    // MARK: Properties
    
    private enum Metrics {
        static let titleTopSpace: CGFloat = 30
        static let roundButtonTopSpace: CGFloat = 100
    }
    
    private enum Sizes {
        static let titleFont: CGFloat = 24
        static let textViewFont: CGFloat = 30
        
        static let roundButtonCornerRadius: CGFloat = 16
    }
    
    private let customViewBuilder: CustomViewBuilder
    
    // MARK: Initialization
    
    init(customViewBuilder: CustomViewBuilder) {
        self.customViewBuilder = customViewBuilder
    }
}

// MARK: Public Methods

extension CustomViewDirector {
    func createCustomViewExample(with action: Selector) {
        let titleLabel = CustomLabelBuilder()
            .setText("Title")
            .setFont(name: "AvenirNext-Bold", size: Sizes.titleFont)
            .setTextAlignment(.center)
            .build()
        
        let normalButton = CustomButtonBuilder()
            .setTitle("Button", for: .normal)
            .build()
        
        let textView = CustomTextViewBuilder()
            .setEditable(false)
            .setText("Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
            .setFontSize(Sizes.textViewFont)
            .setTextColor(.gray)
            .build()
        
        let roundButton = CustomButtonBuilder()
            .setTitle("Round Button", for: .normal)
            .setBackgroundColor(.lightGray)
            .setCornerRadius(Sizes.roundButtonCornerRadius)
            .addTarget(self, action: action, for: .touchUpInside)
            .build()
        
        _ = customViewBuilder
            .addSubview(titleLabel, topSpace: Metrics.titleTopSpace)
            .addButton(normalButton)
            .addSubview(textView)
            .addSubview(roundButton, topSpace: Metrics.roundButtonTopSpace)
    }
}
