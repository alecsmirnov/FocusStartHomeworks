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
        removeSublayers()
        
        if let image = image {
            let newImageLayer = RoundedShadowImageView.createNewImageLayer(
                image: image,
                roundRectBounds: bounds,
                cornerRadius: cornerRadius
            )
            let newShadowLayer = RoundedShadowImageView.createNewShadowLayer(
                roundRectBounds: bounds,
                cornerRadius: cornerRadius,
                shadowColor: shadowColor,
                shadowOpacity: shadowOpacity,
                shadowRadius: shadowRadius,
                shadowOffset: shadowOffset
            )
            
            addSublayers(newImageLayer: newImageLayer, newShadowLayer: newShadowLayer)
        }
    }
    
    func addSublayers(newImageLayer: CAShapeLayer, newShadowLayer: CAShapeLayer) {
        imageLayer = newImageLayer
        shadowLayer = newShadowLayer
        
        layer.addSublayer(newShadowLayer)
        layer.addSublayer(newImageLayer)
    }
    
    func removeSublayers() {
        imageLayer?.removeFromSuperlayer()
        shadowLayer?.removeFromSuperlayer()
        
        imageLayer = nil
        shadowLayer = nil
    }
}

// MARK: - Static Methods

private extension RoundedShadowImageView {
    static func createNewImageLayer(image: UIImage, roundRectBounds: CGRect, cornerRadius: CGFloat) -> CAShapeLayer {
        let imageLayer = CAShapeLayer()
        
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: roundRectBounds, cornerRadius: cornerRadius).cgPath
        
        imageLayer.mask = mask
        imageLayer.contents = image.cgImage
        imageLayer.frame = roundRectBounds
        imageLayer.contentsGravity = .resizeAspectFill
        
        return imageLayer
    }
    
    static func createNewShadowLayer(
        roundRectBounds: CGRect,
        cornerRadius: CGFloat,
        shadowColor: CGColor,
        shadowOpacity: Float,
        shadowRadius: CGFloat,
        shadowOffset: CGSize
    ) -> CAShapeLayer {
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.shadowPath = UIBezierPath(roundedRect: roundRectBounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.shadowColor = shadowColor
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowRadius
        shadowLayer.shadowOffset = shadowOffset
        
        return shadowLayer
    }
}
