//
//  FirstView.swift
//  homework-3
//
//  Created by Admin on 30.10.2020.
//

import UIKit

final class FirstView: UIView {
    typealias actionType = () -> Void
    
    var roundButtonAction: actionType?
    var ovalButtonAction: actionType?
    
    // MARK: Properties
    
    private enum Constants {
        static let horizontalSpace: CGFloat = 16
        static let topSpace: CGFloat = 8
        static let bottomSpace: CGFloat = 8
        
        static let roundButtonSize = CGSize(width: 48, height: 48)
        static let ovalButtonSize = CGSize(width: 128, height: 48)
        
        static let imageViewSize = CGSize(width: 128, height: 128)
        
        static let smallLabelFontSize: CGFloat = 12
        static let mediumLabelFontSize: CGFloat = 18
        static let largeLabelFontSize: CGFloat = 24
    }
    
    // MARK: Subviews
    
    private let stackView = UIStackView()
    
    private let smallLabel = UILabel()
    private let mediumLabel = UILabel()
    private let largeLabel = UILabel()
    
    private let roundButton = UIButton(type: .system)
    private let ovalButton = UIButton(type: .system)
    
    private let imageView = UIImageView()
    private let activityIndicatorView = UIActivityIndicatorView()
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        roundButton.layer.cornerRadius = roundButton.frame.size.width / 2
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupActions()
        
        setupViewAppearance()
        setupSubviews()
        setupLayout()
        
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions

private extension FirstView {
    @objc func didTapRoundButton() {
        roundButtonAction?()
    }
    
    @objc func didTapOvalButton() {
        ovalButtonAction?()
    }
}

// MARK: - Private Methods

private extension FirstView {
    func setupActions() {
        roundButton.addTarget(self, action: #selector(didTapRoundButton), for: .touchUpInside)
        ovalButton.addTarget(self, action: #selector(didTapOvalButton), for: .touchUpInside)
    }
    
    func setupViewAppearance() {
        backgroundColor = .systemBackground
        
        setupStackViewAppearance()
        
        setupSmallLabelAppearance()
        setupMediumLabelAppearance()
        setupLargeLabelAppearance()
        
        setupRoundButtonAppearance()
        setupOvalButtonAppearance()
        
        setupImageViewAppearance()
        setupActivityIndicatorViewAppearance()
    }
    
    func setupSubviews() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(smallLabel)
        stackView.addArrangedSubview(mediumLabel)
        stackView.addArrangedSubview(largeLabel)
        
        stackView.addArrangedSubview(roundButton)
        stackView.addArrangedSubview(ovalButton)
        
        stackView.addArrangedSubview(imageView)
        
        imageView.addSubview(activityIndicatorView)
    }
    
    func setupLayout() {
        setupStackViewLayout()
        
        setupSmallLabelLayout()
        setupMediumLabelLayout()
        setupLargeLabelLayout()
        
        setupRoundButtonLayout()
        setupOvalButtonLayout()
        
        setupImageViewLayout()
        setupActivityIndicatorViewLayout()
    }
}

// MARK: - Appearance

private extension FirstView {
    func setupStackViewAppearance() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
    }
    
    func setupSmallLabelAppearance() {
        smallLabel.text = "Text 1"
        smallLabel.font = UIFont.systemFont(ofSize: Constants.smallLabelFontSize)
        smallLabel.numberOfLines = 1
        smallLabel.textAlignment = .center
        smallLabel.sizeToFit()
    }
    
    func setupMediumLabelAppearance() {
        mediumLabel.text = "Text 2"
        mediumLabel.font = UIFont(name: "Arial Rounded MT Bold", size: Constants.mediumLabelFontSize)
        mediumLabel.numberOfLines = 1
        mediumLabel.textAlignment = .center
        mediumLabel.sizeToFit()
    }
    
    func setupLargeLabelAppearance() {
        largeLabel.text = "Very very very very very very very very very very very very very large text"
        largeLabel.font = UIFont(name: "Courier New", size: Constants.largeLabelFontSize)
        largeLabel.numberOfLines = 2
        largeLabel.textAlignment = .center
        largeLabel.sizeToFit()
    }
    
    func setupRoundButtonAppearance() {
        roundButton.setTitle("Round", for: .normal)
        roundButton.layer.borderWidth = 1
        roundButton.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    func setupOvalButtonAppearance() {
        ovalButton.setTitle("Oval", for: .normal)
        ovalButton.layer.cornerRadius = 8
        ovalButton.layer.borderWidth = 1
        ovalButton.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    func setupImageViewAppearance() {
        imageView.image = UIImage(systemName: "square.fill")
        imageView.contentMode = .scaleToFill
    }
    
    func setupActivityIndicatorViewAppearance() {
        activityIndicatorView.color = .black
        activityIndicatorView.startAnimating()
    }
}

// MARK: - Layouts

private extension FirstView {
    func setupStackViewLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.topSpace),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.bottomSpace),
        ])
    }
    
    func setupSmallLabelLayout() {
        smallLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            smallLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Constants.horizontalSpace),
            smallLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -Constants.horizontalSpace),
        ])
    }
    
    func setupMediumLabelLayout() {
        mediumLabel.translatesAutoresizingMaskIntoConstraints = false
        mediumLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        NSLayoutConstraint.activate([
            mediumLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Constants.horizontalSpace),
            mediumLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -Constants.horizontalSpace),
        ])
    }
    
    func setupLargeLabelLayout() {
        largeLabel.translatesAutoresizingMaskIntoConstraints = false
        largeLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            largeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Constants.horizontalSpace),
            largeLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -Constants.horizontalSpace),
        ])
    }
    
    func setupRoundButtonLayout() {
        roundButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roundButton.widthAnchor.constraint(equalToConstant: Constants.roundButtonSize.width),
            roundButton.heightAnchor.constraint(equalToConstant: Constants.roundButtonSize.height),
        ])
    }
    
    func setupOvalButtonLayout() {
        ovalButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ovalButton.widthAnchor.constraint(equalToConstant: Constants.ovalButtonSize.width),
            ovalButton.heightAnchor.constraint(equalToConstant: Constants.ovalButtonSize.height),
        ])
    }
    
    func setupImageViewLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize.height),
        ])
    }
    
    func setupActivityIndicatorViewLayout() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
    }
}
