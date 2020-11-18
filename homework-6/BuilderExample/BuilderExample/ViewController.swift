//
//  ViewController.swift
//  BuilderExample
//
//  Created by Admin on 18.11.2020.
//

import UIKit

class CustomViewController: UIViewController {
    override func loadView() {
        let button = CustomButtonBuilder()
            .setTitle("Button", for: .normal)
            .build()
        
        let label = CustomLabelBuilder()
            .setText("Label")
            .setFontSize(18)
            .setTextAlignment(.center)
            .build()
        
        let textView = CustomTextViewBuilder()
            .setEditable(false)
            .setText("Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
            .setFontSize(30)
            .setTextColor(.gray)
            .build()
        
        view = CustomViewBuilder()
            .addButton(button, topSpace: 30)
            .addSubview(label)
            .addSubview(textView)
            .build()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
