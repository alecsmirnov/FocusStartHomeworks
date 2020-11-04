//
//  RoundedShadowImageView.swift
//  homework-4
//
//  Created by Admin on 04.11.2020.
//

import UIKit

class RoundedShadowImageView: UIView {
    // MARK: Properties
    
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    var shadowOpacity: Float = 1 { didSet { recalculateAppearance() }}
    var shadowRadius: CGFloat = 5 { didSet { recalculateAppearance() }}
    var shadowOffset: CGSize = .zero { didSet { recalculateAppearance() }}
    var cornerRadius: CGFloat = 16 { didSet { recalculateAppearance() }}
    
    // MARK: Subviews
    
    private let containerView = UIView()
    private let imageView = UIImageView()
    
    // MARK: Initialization
    
    init(frame: CGRect, image: UIImage? = nil) {
        super.init(frame: frame)
        
        self.image = image
        
        setupAppearance(frame: frame)
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension RoundedShadowImageView {
    func recalculateAppearance() {
        setupAppearance(frame: frame)
    }
}

// MARK: - Appearance

private extension RoundedShadowImageView {
    func setupAppearance(frame: CGRect) {
        setupContainerViewAppearance(frame: frame)
        setupImageViewAppearance(frame: frame)
    }
    
    func setupContainerViewAppearance(frame: CGRect) {
        containerView.frame = frame
        containerView.clipsToBounds = false
        
        let path = UIBezierPath(
            roundedRect: containerView.bounds,
            cornerRadius: cornerRadius
        ).cgPath
        
        containerView.layer.shadowPath = path
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = shadowOpacity
        containerView.layer.shadowRadius = shadowRadius
        containerView.layer.shadowOffset = shadowOffset
        containerView.layer.cornerRadius = cornerRadius
    }
    
    func setupImageViewAppearance(frame: CGRect) {
        imageView.frame = frame
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
    }
}

// MARK: - Layout

private extension RoundedShadowImageView {
    func setupSubviews() {
        addSubview(containerView)
        containerView.addSubview(imageView)
    }
    
    func setupLayout() {
        setupContainerViewLayout()
        setupImageViewLayout()
    }
    
    func setupContainerViewLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: frame.width),
            containerView.heightAnchor.constraint(equalToConstant: frame.height),
        ])
    }
    
    func setupImageViewLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor),
        ])
    }
}
