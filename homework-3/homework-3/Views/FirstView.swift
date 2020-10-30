//
//  FirstView.swift
//  homework-3
//
//  Created by Admin on 30.10.2020.
//

import UIKit

class FirstView: UIView {
    typealias actionType = () -> Void
    
    var roundButtonAction: actionType?
    var ovalButtonAction: actionType?
    
    // MARK: - Labels
    
    private(set) lazy var smallLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Text 1"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }()
    
    private(set) lazy var mediumLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Text 2"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }()
    
    private(set) lazy var largeLabel: UILabel = {
        let label = UILabel()
        
        label.text = """
            Very large text. Very large text. Very large text. Very large text. Very large text. Very large text.
            Very large text. Very large text. Very large text. Very large text. Very large text. Very large text.
        """
        label.font = UIFont(name: "Courier New", size: 24)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }()
    
    // MARK: - Buttons
    
    private(set) lazy var roundButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Round", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor

        button.addTarget(self, action: #selector(didTapRoundButton), for: .touchUpInside)
        
        return button
    }()
    
    private(set) lazy var ovalButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Oval", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        
        button.addTarget(self, action: #selector(didTapOvalButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - ImageView
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "square.fill")
        
        return imageView
    }()
    
    // MARK: - ActivityIndicator
    
    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewAppearance()
        setupSubviews()
        setupConstraints()
        
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        roundButton.layer.cornerRadius = roundButton.frame.size.width / 2
    }
    
    // MARK: - Actions
    
    @objc private func didTapRoundButton() {
        roundButtonAction?()
    }
    
    @objc private func didTapOvalButton() {
        ovalButtonAction?()
    }
    
    // MARK: - Private Methods
    
    private func setupViewAppearance() {
        backgroundColor = ViewSettings.backgroundColor
    }
    
    private func setupSubviews() {
        addSubview(smallLabel)
        addSubview(mediumLabel)
        addSubview(largeLabel)
        
        addSubview(roundButton)
        addSubview(ovalButton)
        
        addSubview(imageView)
        
        addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        setupSmallLabelConstraints()
        setupMediumLabelConstraints()
        setupLargeLabelConstraints()
        
        setupRoundButtonConstraints()
        setupOvalButtonConstraints()
        
        setupImageViewConstraints()
        
        setupActivityIndicatorConstraints()
    }
    
    // MARK: - Labels Constraints
    
    private func setupSmallLabelConstraints() {
        smallLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            NSLayoutConstraint(item: smallLabel,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .top,
                               multiplier: 1,
                               constant: 8),
            
            NSLayoutConstraint(item: smallLabel,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0),
            
            NSLayoutConstraint(item: smallLabel,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .leading,
                               multiplier: 1,
                               constant: 10),
            
            NSLayoutConstraint(item: smallLabel,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: -10),
        ])
    }
    
    private func setupMediumLabelConstraints() {
        mediumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            NSLayoutConstraint(item: mediumLabel,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: smallLabel,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 10),
            
            NSLayoutConstraint(item: mediumLabel,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0),
            
            NSLayoutConstraint(item: mediumLabel,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .leading,
                               multiplier: 1,
                               constant: 10),
            
            NSLayoutConstraint(item: mediumLabel,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: -10),
        ])
    }
    
    private func setupLargeLabelConstraints() {
        largeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            NSLayoutConstraint(item: largeLabel,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: mediumLabel,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 10),
            
            NSLayoutConstraint(item: largeLabel,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0),
            
            NSLayoutConstraint(item: largeLabel,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .leading,
                               multiplier: 1,
                               constant: 10),
            
            NSLayoutConstraint(item: largeLabel,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: -10),
        ])
    }
    
    // MARK: - Buttons Constraints
    
    private func setupRoundButtonConstraints() {
        roundButton.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            NSLayoutConstraint(item: roundButton,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: largeLabel,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 10),
            
            NSLayoutConstraint(item: roundButton,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0),

            NSLayoutConstraint(item: roundButton,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 50),

            NSLayoutConstraint(item: roundButton,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 50),
        ])
    }
    
    private func setupOvalButtonConstraints() {
        ovalButton.translatesAutoresizingMaskIntoConstraints = false

        addConstraints([
            NSLayoutConstraint(item: ovalButton,
                               attribute: .top,
                               relatedBy: .greaterThanOrEqual,
                               toItem: roundButton,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 10),
            
            NSLayoutConstraint(item: ovalButton,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0),

            NSLayoutConstraint(item: ovalButton,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 100),

            NSLayoutConstraint(item: ovalButton,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 40),
        ])
    }
    
    // MARK: - ImageView Constraints
    
    private func setupImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addConstraints([
            NSLayoutConstraint(item: imageView,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0),
            
            NSLayoutConstraint(item: imageView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self.safeAreaLayoutGuide,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: -8),
            
            NSLayoutConstraint(item: imageView,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 100),

            NSLayoutConstraint(item: imageView,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 100),
        ])
    }
    
    // MARK: - ActivityIndicator Constraints
    
    private func setupActivityIndicatorConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        addConstraints([
            NSLayoutConstraint(item: activityIndicator,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: imageView,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0),
            
            NSLayoutConstraint(item: activityIndicator,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: imageView,
                               attribute: .centerY,
                               multiplier: 1,
                               constant: 0),
            
            NSLayoutConstraint(item: activityIndicator,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 40),

            NSLayoutConstraint(item: activityIndicator,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 40),
        ])
    }
}
