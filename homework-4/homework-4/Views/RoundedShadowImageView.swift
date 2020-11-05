//
//  RoundedShadowImageView.swift
//  homework-4
//
//  Created by Admin on 04.11.2020.
//

import UIKit

final class RoundedShadowImageView: UIView {
    // MARK: Properties
    
    var image: UIImage? {
        return imageView.image
    }
    
    var shadowOpacity: Float = 1
    var shadowRadius: CGFloat = 5
    var shadowOffset: CGSize = .zero
    var cornerRadius: CGFloat = 16
    
    private(set) var isCalculated = false
    
    // MARK: Subviews
    
    private let containerView = UIView()
    private let imageView = UIImageView()
    
    // MARK: Initialization
    
    init(size: CGSize, image: UIImage? = nil) {
        let newFrame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        super.init(frame: newFrame)
        
        calculate(newFrame: newFrame, image: image)
    }
    
    convenience init() {
        self.init(size: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension RoundedShadowImageView {
    func setSize(width: CGFloat, height: CGFloat) {
        let newFrame = CGRect(x: 0, y: 0, width: width, height: height)
        
        calculate(newFrame: newFrame, image: image)
    }
    
    func setImage(image: UIImage?) {
        calculate(newFrame: frame, image: image)
    }
}

// MARK: - Private Methods

private extension RoundedShadowImageView {
    func calculate(newFrame: CGRect, image: UIImage?) {
        frame = newFrame
        imageView.image = image
        
        if !isCalculated && imageView.image != nil && frame.width != 0 && frame.height != 0 {
            setupAppearance(frame: frame)
            setupSubviews()
            setupLayout()
            
            isCalculated = true
        }
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
            containerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            containerView.widthAnchor.constraint(equalToConstant: frame.width),
            containerView.heightAnchor.constraint(equalToConstant: frame.height),
        ])
    }
    
    func setupImageViewLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: containerView.frame.width),
            imageView.heightAnchor.constraint(equalToConstant: containerView.frame.height),
        ])
    }
}
