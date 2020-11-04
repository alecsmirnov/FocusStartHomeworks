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
        
        static let imageViewSize = CGSize(width: 128, height: 128)
    }
    
    // MARK: Subviews
    
    private let scrollView = UIScrollView()
    
    private let textLabel = UILabel()
    
    private let firstImageView = UIImageView()
    private let secondImageView = UIImageView()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppearance()
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension DetailView {
    func customize(text: String?, firstImage: UIImage?, secondImage: UIImage?) {
        textLabel.text = text
        
        firstImageView.image = firstImage
        secondImageView.image = secondImage
    }
}

// MARK: - Appearance

private extension DetailView {
    func setupAppearance() {
        backgroundColor = .systemBackground
        
        setupScrollViewAppearance()
        
        setTextLabelAppearance()
        setFirstImageViewAppearance()
        setSecondImageViewAppearance()
    }
    
    func setupScrollViewAppearance() {
        scrollView.backgroundColor = .systemBackground
    }
    
    func setTextLabelAppearance() {
        textLabel.numberOfLines = 0
    }
    
    func setFirstImageViewAppearance() {
        firstImageView.contentMode = .scaleAspectFill
        firstImageView.clipsToBounds = true
    }
    
    func setSecondImageViewAppearance() {
        secondImageView.contentMode = .scaleAspectFill
        secondImageView.clipsToBounds = true
    }
}

// MARK: - Layouts

private extension DetailView {
    func setupSubviews() {
        addSubview(scrollView)
        
        scrollView.addSubview(textLabel)
        scrollView.addSubview(firstImageView)
        scrollView.addSubview(secondImageView)
    }
    
    func setupLayout() {
        setupScrollViewLayout()
        
        setupTextLabelLayout()
        setFirstImageViewLayout()
        setSecondImageViewLayout()
    }
    
    func setupScrollViewLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setupTextLabelLayout() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.horizontalSpace),
            textLabel.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -Constants.horizontalSpace),
            textLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.verticalSpace),
        ])
    }
    
    func setFirstImageViewLayout() {
        firstImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            firstImageView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: Constants.verticalSpace),
            firstImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize.width),
            firstImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize.height),
        ])
    }
    
    func setSecondImageViewLayout() {
        secondImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            secondImageView.topAnchor.constraint(
                equalTo: firstImageView.bottomAnchor,
                constant: Constants.verticalSpace),
            secondImageView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor,
                constant: -Constants.verticalSpace),
            secondImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize.width),
            secondImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize.height),
        ])
    }
}
