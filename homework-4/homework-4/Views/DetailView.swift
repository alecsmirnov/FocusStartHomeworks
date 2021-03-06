//
//  DetailView.swift
//  homework-4
//
//  Created by Admin on 03.11.2020.
//

import UIKit

final class DetailView: UIView {
    // MARK: Properties
    
    private enum Constants {
        static let horizontalSpace: CGFloat = 8
        static let verticalSpace: CGFloat = 8
        
        static let imageSize = CGSize(width: 300, height: 300)
        static let imageCornerRadius: CGFloat = 16
    }
    
    // MARK: Subviews
    
    private let scrollView = UIScrollView()
    
    private let textLabel = UILabel()
    
    private let firstImageView = RoundedShadowImageView()
    private let secondImageView = RoundedShadowImageView()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension DetailView {
    func customize(record: Record) {
        textLabel.text = record.text
        firstImageView.image = record.firstImage
        secondImageView.image = record.secondImage
    }
}

// MARK: - Appearance

private extension DetailView {
    func setupAppearance() {
        backgroundColor = .systemBackground

        setupTextLabelAppearance()
        setupFirstImageViewAppearance()
        setupSecondImageViewAppearance()
    }
    
    func setupTextLabelAppearance() {
        textLabel.numberOfLines = 0
    }
    
    func setupFirstImageViewAppearance() {
        firstImageView.cornerRadius = Constants.imageCornerRadius
    }
    
    func setupSecondImageViewAppearance() {
        secondImageView.cornerRadius = Constants.imageCornerRadius
    }
}

// MARK: - Layouts

private extension DetailView {
    func setupLayout() {
        setupSubviews()
        
        setupScrollViewLayout()
        
        setupTextLabelLayout()
        setupFirstImageViewLayout()
        setupSecondImageViewLayout()
    }
    
    func setupSubviews() {
        addSubview(scrollView)
        
        scrollView.addSubview(textLabel)
        scrollView.addSubview(firstImageView)
        scrollView.addSubview(secondImageView)
    }
    
    func setupScrollViewLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setupTextLabelLayout() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.verticalSpace),
            textLabel.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.horizontalSpace
            ),
            textLabel.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -Constants.horizontalSpace
            ),
        ])
    }
    
    func setupFirstImageViewLayout() {
        firstImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstImageView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: Constants.verticalSpace),
            firstImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            firstImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize.width),
            firstImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize.height),
        ])
    }
    
    func setupSecondImageViewLayout() {
        secondImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondImageView.topAnchor.constraint(
                equalTo: firstImageView.bottomAnchor,
                constant: Constants.verticalSpace
            ),
            secondImageView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor,
                constant: -Constants.verticalSpace
            ),
            secondImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            secondImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize.width),
            secondImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize.height),
        ])
    }
}
