//
//  RoundedShadowImageView.swift
//  homework-4
//
//  Created by Admin on 04.11.2020.
//

import UIKit

final class RoundedShadowImageView: UIView {
    // MARK: Properties
    
    var cornerRadius: CGFloat = 16
    
    var shadowColor: CGColor = UIColor.black.cgColor
    var shadowOpacity: Float = 1
    var shadowRadius: CGFloat = 5
    var shadowOffset: CGSize = .zero
    
    var image: UIImage? {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: Sublayers
    
    private var imageLayer: CAShapeLayer?
    private var shadowLayer: CAShapeLayer?
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureSublayers()
    }
    
    // MARK: Initialization
    
    init(image: UIImage? = nil) {
        super.init(frame: .zero)
        
        self.image = image
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Appearance

private extension RoundedShadowImageView {
    func configureView() {
        backgroundColor = .systemBackground
        clipsToBounds = false
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

// MARK: - Sublayers

private extension RoundedShadowImageView {
    func configureSublayers() {
        if let image = image {
            addSublayers()
            
            RoundedShadowImageView.configureImageLayer(
                imageLayer,
                image: image,
                roundRectBounds: bounds,
                cornerRadius: cornerRadius
            )
            RoundedShadowImageView.configureShadowLayer(
                shadowLayer,
                roundRectBounds: bounds,
                cornerRadius: cornerRadius,
                shadowColor: shadowColor,
                shadowOpacity: shadowOpacity,
                shadowRadius: shadowRadius,
                shadowOffset: shadowOffset
            )
        } else {
            removeSublayers()
        }
    }
    
    func addSublayers() {
        if shadowLayer == nil {
            let newShadowLayer = CAShapeLayer()
            
            shadowLayer = newShadowLayer
            layer.addSublayer(newShadowLayer)
        }
        
        if imageLayer == nil {
            let newImageLayer = CAShapeLayer()
            
            imageLayer = newImageLayer
            layer.addSublayer(newImageLayer)
        }
    }
    
    func removeSublayers() {
        imageLayer?.removeFromSuperlayer()
        shadowLayer?.removeFromSuperlayer()
        
        imageLayer = nil
        shadowLayer = nil
    }
}

// MARK: - Sublayers Static Methods

private extension RoundedShadowImageView {
    static func configureImageLayer(
        _ imageLayer: CAShapeLayer?,
        image: UIImage,
        roundRectBounds: CGRect,
        cornerRadius: CGFloat
    ) {
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: roundRectBounds, cornerRadius: cornerRadius).cgPath
        
        imageLayer?.mask = mask
        imageLayer?.contents = image.cgImage
        imageLayer?.frame = roundRectBounds
        imageLayer?.contentsGravity = .resizeAspectFill
    }
    
    static func configureShadowLayer(
        _ shadowLayer: CAShapeLayer?,
        roundRectBounds: CGRect,
        cornerRadius: CGFloat,
        shadowColor: CGColor,
        shadowOpacity: Float,
        shadowRadius: CGFloat,
        shadowOffset: CGSize
    ) {
        shadowLayer?.shadowPath = UIBezierPath(roundedRect: roundRectBounds, cornerRadius: cornerRadius).cgPath
        shadowLayer?.shadowColor = shadowColor
        shadowLayer?.shadowOpacity = shadowOpacity
        shadowLayer?.shadowRadius = shadowRadius
        shadowLayer?.shadowOffset = shadowOffset
    }
}
