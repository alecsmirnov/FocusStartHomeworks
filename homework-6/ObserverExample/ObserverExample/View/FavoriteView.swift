//
//  FavoriteView.swift
//  ObserverExample
//
//  Created by Admin on 19.11.2020.
//

import UIKit

final class FavoriteView: UIView {
    // MARK: Properties
    
    var favoriteButtonAction: ButtonPressCompletion?
    
    private enum Constants {
        static let hintLabelDeadline: Double = 1
        static let hintLabelAnimationDuration: Double = 0.3
    }
    
    private enum Metrics {
        static let verticalSpace: CGFloat = 8
    }
    
    private enum ImageNames {
        static let star = "star"
        static let starFill = "star.fill"
    }
    
    private var isEven = false
    
    // MARK: Subviews
    
    private let hintLabel = UILabel()
    private let imageView = UIImageView()
    private let favoriteButton = UIButton(type: .system)

    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)
        
        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension FavoriteView {
    func showHintLabel() {
        animateLabel(alpha: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.hintLabelDeadline) { [weak self] in
            self?.animateLabel(alpha: 0)
        }
    }
    
    func animateLabel(alpha: CGFloat) {
        UIView.transition(
            with: hintLabel,
            duration: Constants.hintLabelAnimationDuration,
            options: .transitionCrossDissolve
        ) {
            self.hintLabel.alpha = alpha
        }
    }
    
    func toggleImage() {
        imageView.image = isEven ? UIImage(systemName: ImageNames.star) : UIImage(systemName: ImageNames.starFill)
        
        isEven.toggle()
    }
}

// MARK: - Actions

private extension FavoriteView {
    @objc func didPressFavoriteButton() {
        showHintLabel()
        toggleImage()
        
        favoriteButtonAction?()
    }
}

// MARK: - Appearance

private extension FavoriteView {
    func setupAppearance() {
        backgroundColor = .systemBackground
        
        setupImageViewAppearance()
        setupFavoriteButtonAppearance()
        setupHintLabelAppearance()
    }
    
    func setupHintLabelAppearance() {
        hintLabel.text = "Updated!"
        hintLabel.alpha = 0
    }
    
    func setupImageViewAppearance() {
        imageView.image = UIImage(systemName: ImageNames.star)
    }
    
    func setupFavoriteButtonAppearance() {
        favoriteButton.setTitle("Push me", for: .normal)
        favoriteButton.sizeToFit()
        
        favoriteButton.addTarget(self, action: #selector(didPressFavoriteButton), for: .touchUpInside)
    }
}

// MARK: - Layouts

private extension FavoriteView {
    func setupLayout() {
        setupSubviews()
        
        setupHintLabelLayout()
        setupImageViewLayout()
        setupFavoriteButtonLayout()
    }
    
    func setupSubviews() {
        addSubview(hintLabel)
        addSubview(imageView)
        addSubview(favoriteButton)
    }
    
    func setupHintLabelLayout() {
        hintLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hintLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -Metrics.verticalSpace * 2),
            hintLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    func setupImageViewLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: favoriteButton.topAnchor, constant: -Metrics.verticalSpace),
            imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    func setupFavoriteButtonLayout() {
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            favoriteButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        ])
    }
}

// MARK: - Observer

extension FavoriteView: IObserver {
    func update() {
        toggleImage()
    }
}
