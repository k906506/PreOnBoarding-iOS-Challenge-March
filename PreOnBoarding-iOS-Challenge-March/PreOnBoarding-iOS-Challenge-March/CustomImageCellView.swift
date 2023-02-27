//
//  CustomImageCellView.swift
//  PreOnBoarding-iOS-Challenge-March
//
//  Created by 고도 on 2023/02/26.
//

import UIKit

final class CustomImageCellView: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        
        return progressView
    }()
    
    private lazy var loadButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Load"
        configuration.cornerStyle = .medium
        button.configuration = configuration
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomImageCellView {
    func setupLayout() {
        [imageView, progressView, loadButton].forEach { addSubview($0) }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 128).isActive = true

        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        progressView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12).isActive = true
        progressView.trailingAnchor.constraint(equalTo: loadButton.leadingAnchor, constant: -12).isActive = true
        progressView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        loadButton.translatesAutoresizingMaskIntoConstraints = false
        loadButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
    }
}
