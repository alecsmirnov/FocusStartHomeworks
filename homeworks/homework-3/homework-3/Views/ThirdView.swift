//
//  ThirdView.swift
//  homework-3
//
//  Created by Admin on 30.10.2020.
//

import UIKit

final class ThirdView: UIView {
    // MARK: Properties
    
    var enterButtonAction: LoginButtonPressCompletion?
    
    private enum Constants {
        static let horizontalSpace: CGFloat = 8
        static let verticalSpace: CGFloat = 8
        
        static let enterButtonSize = CGSize(width: 128, height: 48)
        
        static let animationDuration: TimeInterval = 0.3
    }
    
    private var enterButtonBottomConstraint: NSLayoutConstraint?
    
    // MARK: Subviews
    
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let enterButton = UIButton(type: .system)
    
    // MARK: Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAction()
        setupKeyboardObservers()
        
        setupViewAppearance()
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions

private extension ThirdView {
    func setupAction() {
        enterButton.addTarget(self, action: #selector(didTapEnterButton), for: .touchUpInside)
    }
    
    @objc func didTapEnterButton() {
        let login = loginTextField.text
        let password = passwordTextField.text
        
        enterButtonAction?(login, password)
    }
}

// MARK: - Keyboard Events

private extension ThirdView {
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        if enterButtonBottomConstraint?.constant == -Constants.verticalSpace {
            let keyboardTop = self.safeAreaInsets.bottom - keyboardSize.cgRectValue.height
            enterButtonBottomConstraint?.constant = keyboardTop - Constants.verticalSpace
            
            UIView.animate(withDuration: Constants.animationDuration) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if enterButtonBottomConstraint?.constant != -Constants.verticalSpace {
            enterButtonBottomConstraint?.constant = -Constants.verticalSpace
            
            UIView.animate(withDuration: Constants.animationDuration) {
                self.layoutIfNeeded()
            }
        }
    }
}

// MARK: - Appearance

private extension ThirdView {
    func setupViewAppearance() {
        backgroundColor = .systemBackground
        
        setupLoginTextFieldAppearance()
        setupPasswordTextFieldAppearance()
        
        setupEnterButtonAppearance()
    }
    
    func setupLoginTextFieldAppearance() {
        loginTextField.placeholder = "Enter login"
        loginTextField.borderStyle = .roundedRect
    }
    
    func setupPasswordTextFieldAppearance() {
        passwordTextField.placeholder = "Enter password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupEnterButtonAppearance() {
        enterButton.setTitle("Enter", for: .normal)
        enterButton.layer.cornerRadius = 8
        enterButton.layer.borderWidth = 1
        enterButton.layer.borderColor = UIColor.systemGray4.cgColor
    }
}

// MARK: - Layouts

private extension ThirdView {
    func setupSubviews() {
        addSubview(loginTextField)
        addSubview(passwordTextField)
        
        addSubview(enterButton)
    }
    
    func setupLayout() {
        setupLoginTextFieldLayout()
        setupPasswordTextFieldLayout()
        
        setupEnterButtonLayout()
    }
    
    func setupLoginTextFieldLayout() {
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.horizontalSpace),
            loginTextField.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -Constants.horizontalSpace),
            loginTextField.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: Constants.verticalSpace),
        ])
    }
    
    func setupPasswordTextFieldLayout() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.horizontalSpace),
            passwordTextField.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -Constants.horizontalSpace),
            passwordTextField.topAnchor.constraint(
                equalTo: loginTextField.bottomAnchor,
                constant: Constants.verticalSpace),
        ])
    }
    
    func setupEnterButtonLayout() {
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        enterButtonBottomConstraint = enterButton.bottomAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.bottomAnchor,
            constant: -Constants.verticalSpace)
        enterButtonBottomConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            enterButton.widthAnchor.constraint(equalToConstant: Constants.enterButtonSize.width),
            enterButton.heightAnchor.constraint(equalToConstant: Constants.enterButtonSize.height),
            enterButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
}
