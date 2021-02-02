//
//  SecondView.swift
//  homework-3
//
//  Created by Admin on 30.10.2020.
//

import UIKit

final class SecondView: UIView {
    // MARK: Properties
    
    private enum Constants {
        static let horizontalSpace: CGFloat = 8
        static let verticalSpace: CGFloat = 8
        
        static let imageViewSize = CGSize(width: 200, height: 200)
        
        static let titleLabelFontSize: CGFloat = 18
        static let textLabelFontSize: CGFloat = 18
    }
    
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
    
    // MARK: Subviews
    
    private let scrollView = UIScrollView()
    
    private let imageView = UIImageView()
    
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
    
    // MARK: Life Cycle

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        changeViewLayout(traitCollection: traitCollection, previousTraitCollection: previousTraitCollection)
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewAppearance()
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Appearance

private extension SecondView {
    func setupViewAppearance() {
        backgroundColor = .systemBackground
        
        setupScrollViewAppearance()
        
        setupImageViewAppearance()
        setupTitleLabelAppearance()
        setupTextLabelAppearance()
    }
    
    func setupScrollViewAppearance() {
        scrollView.backgroundColor = .systemBackground
    }
    
    func setupImageViewAppearance() {
        imageView.image = UIImage(systemName: "square.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    func setupTitleLabelAppearance() {
        titleLabel.text = "Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title"
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleLabelFontSize)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
    }
    
    func setupTextLabelAppearance() {
        textLabel.text = """
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
            TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
        """
        
        textLabel.font = UIFont.systemFont(ofSize: Constants.textLabelFontSize)
        textLabel.numberOfLines = 0
    }
}

// MARK: - Applying Layouts

private extension SecondView {
    func setupSubviews() {
        addSubview(scrollView)
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(textLabel)
    }
    
    func setupLayout() {
        setupSharedLayout()
        
        prepareCompactLayout()
        prepareRegularLayout()
        
        changeViewLayout(traitCollection: traitCollection)
    }
    
    func setupSharedLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        prepareScrollViewSharedLayout()
        prepareTextLabelSharedLayout()
        
        NSLayoutConstraint.activate(sharedConstraints)
    }
    
    func prepareCompactLayout() {
        prepareImageViewCompactLayout()
        prepareTitleLabelCompactLayout()
    }
    
    func prepareRegularLayout() {
        prepareImageViewRegularLayout()
        prepareTitleLabelRegularLayout()
    }
    
    func changeViewLayout(traitCollection: UITraitCollection, previousTraitCollection: UITraitCollection? = nil) {
        guard traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass ||
              traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass else { return }
        
        switch(traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.compact, .regular): activateCompactLayout()
        default:                   activateRegularLayout()
        }
    }
    
    func activateCompactLayout() {
        NSLayoutConstraint.deactivate(regularConstraints)
        NSLayoutConstraint.activate(compactConstraints)
    }
    
    func activateRegularLayout() {
        NSLayoutConstraint.deactivate(compactConstraints)
        NSLayoutConstraint.activate(regularConstraints)
    }
}

// MARK: - Prepare Shared Layouts

private extension SecondView {
    func prepareScrollViewSharedLayout() {
        sharedConstraints.append(contentsOf: [
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func prepareTextLabelSharedLayout() {
        sharedConstraints.append(contentsOf: [
            textLabel.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.horizontalSpace),
            textLabel.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -Constants.horizontalSpace),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.verticalSpace),
            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
}

// MARK: - Prepare Compact Layouts

private extension SecondView {
    func prepareImageViewCompactLayout() {
        compactConstraints.append(contentsOf: [
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
    }
    
    func prepareTitleLabelCompactLayout() {
        compactConstraints.append(contentsOf: [
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.verticalSpace),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

// MARK: - Prepare Regular Layouts

private extension SecondView {
    func prepareImageViewRegularLayout() {
        regularConstraints.append(contentsOf: [
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.verticalSpace),
            imageView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.horizontalSpace),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize.height),
        ])
    }
    
    func prepareTitleLabelRegularLayout() {
        regularConstraints.append(contentsOf: [
            titleLabel.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: Constants.horizontalSpace),
            titleLabel.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -Constants.horizontalSpace),
            titleLabel.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
    }
}
