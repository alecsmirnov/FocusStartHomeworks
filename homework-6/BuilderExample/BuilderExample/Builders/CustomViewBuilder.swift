//
//  CustomViewBuilder.swift
//  BuilderExample
//
//  Created by Admin on 18.11.2020.
//

import UIKit

protocol ICustomViewBuilder {
    func addButton(_ button: UIButton, topSpace: CGFloat) -> Self
    func addSubview(_ subview: UIView, topSpace: CGFloat, horizontalSpace: CGFloat) -> Self
    
    func build() -> UIView
}

final class CustomViewBuilder {
    private enum Metrics {
        static let topSpace: CGFloat = 8
        static let horizontalSpace: CGFloat = 16
    }
    
    private let view = UIView(frame: .zero)
    
    private var subviewsTopAnchor: NSLayoutYAxisAnchor
    
    init() {
        view.backgroundColor = .white
        
        subviewsTopAnchor = view.safeAreaLayoutGuide.topAnchor
    }
}

// MARK: - ICustomViewBuilder

extension CustomViewBuilder: ICustomViewBuilder {
    func addButton(_ button: UIButton, topSpace: CGFloat) -> Self {
        setupButtonLayout(button, topSpace: topSpace)
        
        return self
    }
    
    func addSubview(_ subview: UIView, topSpace: CGFloat, horizontalSpace: CGFloat) -> Self {
        setupSubviewLayout(subview, topSpace: topSpace, horizontalSpace: horizontalSpace)
        
        return self
    }
    
    func build() -> UIView {
        return view
    }
}

extension CustomViewBuilder {
    func addButton(_ button: UIButton) -> Self {
        return addSubview(button, topSpace: Metrics.topSpace, horizontalSpace: Metrics.horizontalSpace)
    }
    
    func addSubview(_ subview: UIView) -> Self {
        return addSubview(subview, topSpace: Metrics.topSpace, horizontalSpace: Metrics.horizontalSpace)
    }
    
    func addSubview(_ subview: UIView, topSpace: CGFloat) -> Self {
        return addSubview(subview, topSpace: topSpace, horizontalSpace: Metrics.horizontalSpace)
    }
}

// MARK: - Layouts

private extension CustomViewBuilder {    
    func setupButtonLayout(_ button: UIButton, topSpace: CGFloat) {
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: subviewsTopAnchor, constant: topSpace),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        subviewsTopAnchor = button.bottomAnchor
    }
    
    func setupSubviewLayout(_ subview: UIView, topSpace: CGFloat, horizontalSpace: CGFloat) {
        view.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: subviewsTopAnchor, constant: topSpace),
            subview.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: horizontalSpace
            ),
            subview.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -horizontalSpace
            ),
        ])
        
        subviewsTopAnchor = subview.bottomAnchor
    }
}
