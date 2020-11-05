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
    
    var shadowColor: CGColor = UIColor.black.cgColor
    var shadowOpacity: Float = 1
    var shadowRadius: CGFloat = 5
    var shadowOffset: CGSize = .zero
    
    var cornerRadius: CGFloat = 16
    
    private(set) var isCalculated = false
    
    // MARK: Subviews
    
    private let imageView = UIImageView()
    
    // MARK: Initialization
    
    init(size: CGSize, image: UIImage? = nil) {
        let newFrame = CGRect(origin: .zero, size: size)
        
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
        setupViewLayerAppearance(frame: frame)
        setupImageViewLayerAppearance(frame: frame)
    }
    
    func setupViewLayerAppearance(frame: CGRect) {
        self.frame = frame
        clipsToBounds = false
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.cornerRadius = cornerRadius
    }
    
    func setupImageViewLayerAppearance(frame: CGRect) {
        imageView.frame = frame
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
    }
}

// MARK: - Layout

private extension RoundedShadowImageView {
    func setupSubviews() {
        addSubview(imageView)
    }
    
    func setupLayout() {
        setupImageViewLayout()
    }
    
    func setupImageViewLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: frame.width),
            imageView.heightAnchor.constraint(equalToConstant: frame.height),
        ])
    }
}
