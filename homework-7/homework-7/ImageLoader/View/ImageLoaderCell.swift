//
//  ImageLoaderCell.swift
//  homework-7
//
//  Created by Admin on 30.11.2020.
//

import UIKit

protocol IImageLoaderCell: AnyObject {}

protocol ImageLoaderCellDelegate: AnyObject {
    func imageLoaderPauseButtonPressed(_ imageLoaderCell: ImageLoaderCell)
    func imageLoaderResumeButtonPressed(_ imageLoaderCell: ImageLoaderCell)
    func imageLoaderCancelButtonPressed(_ imageLoaderCell: ImageLoaderCell)
}

final class ImageLoaderCell: UITableViewCell {
    typealias ButtonPress = () -> Void
    
    // MARK: Properties
    
    weak var delegate: ImageLoaderCellDelegate?
       
    static let reuseIdentifier = String(describing: self)
    
    enum ImageLoaderCellType {
        case loading
        case presentation
    }
    
    private enum Constants {
        static let progressFormatPercentage: Float = 100
        
        static let animationDuration = 0.3
    }

    private enum ImageNames {
        static let pause = "pause.circle"
        static let resume = "play.circle"
        static let cancel = "multiply.circle"
    }
    
    private enum Metrics {
        static let verticalSpace: CGFloat = 8
        static let horizontalSpace: CGFloat = 16
        
        static let horizontalSpaceBetweenButtons: CGFloat = 0
        static let horizontalSpaceBetweenProgressItems: CGFloat = 8
        
        static let pauseResumeButtonHeight: CGFloat = 44
        static let pauseResumeButtonWidth: CGFloat = 44
        
        static let cancelButtonHeight: CGFloat = 30
        static let cancelButtonWidth: CGFloat = 30
        
        static let imageViewHeight: CGFloat = 200
    }
    
    private enum LayoutPriority {
        static let bottom: Float = 750
    }
    
    private var type = ImageLoaderCellType.loading
    
    private var isPaused = true
    
    private var loadingConstraints = [NSLayoutConstraint]()
    private var presentationConstraints = [NSLayoutConstraint]()
    
    // MARK: Subviews
    
    private let mainImageView = UIImageView()
    
    private let pauseResumeButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    private let progressView = UIProgressView()
    private let progressLabel = UILabel()
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAppearance()
        prepareLayout()
        applyLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - IImageLoaderCell

extension ImageLoaderCell: IImageLoaderCell {}

// MARK: - Public Methods

extension ImageLoaderCell {
    func updateLoading(progress: Float, totalSize: String) {
        progressView.progress = progress
        progressLabel.text = String(format: "%.1f%% of %@", progress * Constants.progressFormatPercentage, totalSize)
    }
    
    func setImage(_ image: UIImage) {
        mainImageView.image = image
    }
    
    func setType(_ type: ImageLoaderCellType) {
        self.type = type
        
        applyLayout()
        
        UIView.animate(withDuration: Constants.animationDuration) {
            self.contentView.layoutIfNeeded()
        }
    }
}

// MARK: - Appearance

private extension ImageLoaderCell {
    func setupAppearance() {
        setupLoadingAppearance()
        setupPresentationAppearance()
        
        selectionStyle = .none
    }
    
    func setupLoadingAppearance() {
        setupPauseResumeButtonAppearance()
        setupCancelButtonAppearance()
    }
    
    func setupPresentationAppearance() {
        setupMainImageViewAppearance()
    }
    
    func setupPauseResumeButtonAppearance() {
        let image = isPaused ? UIImage(systemName: ImageNames.pause) : UIImage(systemName: ImageNames.cancel)
        
        pauseResumeButton.setImage(image, for: .normal)
        pauseResumeButton.imageView?.contentMode = .scaleAspectFit
        pauseResumeButton.imageView?.clipsToBounds = true
        pauseResumeButton.contentHorizontalAlignment = .fill
        pauseResumeButton.contentVerticalAlignment = .fill
        
        pauseResumeButton.addTarget(self, action: #selector(didPressPauseResumeButton), for: .touchUpInside)
    }
    
    func setupCancelButtonAppearance() {
        let image = UIImage(systemName: ImageNames.cancel)
        
        cancelButton.setImage(image, for: .normal)
        cancelButton.imageView?.contentMode = .scaleAspectFit
        cancelButton.imageView?.clipsToBounds = true
        cancelButton.contentHorizontalAlignment = .fill
        cancelButton.contentVerticalAlignment = .fill
        
        cancelButton.addTarget(self, action: #selector(didPressCancelButton), for: .touchUpInside)
    }
    
    func setupMainImageViewAppearance() {
        mainImageView.contentMode = .scaleAspectFit
    }
}

// MARK: - Actions

private extension ImageLoaderCell {
    @objc func didPressPauseResumeButton() {
        let newImage: UIImage?
        
        if isPaused {
            delegate?.imageLoaderPauseButtonPressed(self)
            
            newImage = UIImage(systemName: ImageNames.resume)
        } else {
            delegate?.imageLoaderResumeButtonPressed(self)
            
            newImage = UIImage(systemName: ImageNames.pause)
        }
        
        pauseResumeButton.setImage(newImage, for: .normal)
        isPaused.toggle()
    }
    
    @objc func didPressCancelButton() {
        delegate?.imageLoaderCancelButtonPressed(self)
    }
}

// MARK: - Apply Layout

private extension ImageLoaderCell {
    func prepareLayout() {
        prepareLoadingLayout()
        preparePresentationLayout()
    }
    
    func applyLayout() {
        switch type {
        case .loading: setupLoadingLayout()
        case .presentation: setupPresentationLayout()
        }
    }
    
    func setupLoadingLayout() {
        removePresentationSubviews()
        setupLoadingSubviews()
        
        NSLayoutConstraint.deactivate(presentationConstraints)
        NSLayoutConstraint.activate(loadingConstraints)
    }
    
    func setupPresentationLayout() {
        removeLoadingSubviews()
        setupPresentationSubviews()
        
        NSLayoutConstraint.deactivate(loadingConstraints)
        NSLayoutConstraint.activate(presentationConstraints)
    }
}

// MARK: - Subviews

private extension ImageLoaderCell {
    func setupLoadingSubviews() {
        contentView.addSubview(pauseResumeButton)
        contentView.addSubview(cancelButton)
        contentView.addSubview(progressView)
        contentView.addSubview(progressLabel)
    }
    
    func removeLoadingSubviews() {
        pauseResumeButton.removeFromSuperview()
        cancelButton.removeFromSuperview()
        progressView.removeFromSuperview()
        progressLabel.removeFromSuperview()
    }
    
    func setupPresentationSubviews() {
        contentView.addSubview(mainImageView)
    }
    
    func removePresentationSubviews() {
        mainImageView.removeFromSuperview()
    }
}

// MARK: - Prepare Loading Layout

private extension ImageLoaderCell {
    func prepareLoadingLayout() {
        preparePauseResumeButtonLayout()
        prepareCancelButtonLayout()
        prepareProgressViewLayout()
        prepareProgressLabelLayout()
    }
    
    func preparePauseResumeButtonLayout() {
        pauseResumeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let pauseResumeButtonBottomAnchor = pauseResumeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                                                      constant: -Metrics.verticalSpace)
        pauseResumeButtonBottomAnchor.priority = UILayoutPriority(LayoutPriority.bottom)
        
        loadingConstraints.append(contentsOf: [
            pauseResumeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.verticalSpace),
            pauseResumeButtonBottomAnchor,
            pauseResumeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                       constant: Metrics.horizontalSpace),
            pauseResumeButton.heightAnchor.constraint(equalToConstant: Metrics.pauseResumeButtonHeight),
            pauseResumeButton.widthAnchor.constraint(equalToConstant: Metrics.pauseResumeButtonWidth),
        ])
    }
    
    func prepareCancelButtonLayout() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        loadingConstraints.append(contentsOf: [
            cancelButton.leadingAnchor.constraint(equalTo: pauseResumeButton.trailingAnchor,
                                                  constant: Metrics.horizontalSpaceBetweenButtons),
            cancelButton.centerYAnchor.constraint(equalTo: pauseResumeButton.centerYAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: Metrics.cancelButtonHeight),
            cancelButton.widthAnchor.constraint(equalToConstant: Metrics.cancelButtonWidth),
        ])
    }
    
    func prepareProgressViewLayout() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        loadingConstraints.append(contentsOf: [
            progressView.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor,
                                                  constant: Metrics.horizontalSpace),
            progressView.centerYAnchor.constraint(equalTo: pauseResumeButton.centerYAnchor),
        ])
    }
    
    func prepareProgressLabelLayout() {
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loadingConstraints.append(contentsOf: [
            progressLabel.leadingAnchor.constraint(equalTo: progressView.trailingAnchor,
                                                   constant: Metrics.horizontalSpaceBetweenProgressItems),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Metrics.horizontalSpace),
            progressLabel.centerYAnchor.constraint(equalTo: pauseResumeButton.centerYAnchor),
        ])
    }
}

// MARK: - Prepare Presentation Layout

private extension ImageLoaderCell {
    func preparePresentationLayout() {
        prepareMainImageViewLayout()
    }
    
    func prepareMainImageViewLayout() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let mainImageViewBottomAnchor = mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                                              constant: -Metrics.verticalSpace)
        mainImageViewBottomAnchor.priority = UILayoutPriority(LayoutPriority.bottom)
        
        presentationConstraints.append(contentsOf: [
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.verticalSpace),
            mainImageViewBottomAnchor,
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: Metrics.horizontalSpace),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Metrics.horizontalSpace),
            mainImageView.heightAnchor.constraint(equalToConstant: Metrics.imageViewHeight),
        ])
    }
}
