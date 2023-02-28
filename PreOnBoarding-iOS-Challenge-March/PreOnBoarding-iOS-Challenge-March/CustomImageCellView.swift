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
        button.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func loadButtonTapped(_ sender: UIButton) {
        // 이미지 로딩 과정에서 Default 이미지를 보여주는 코드
        DispatchQueue.main.async {
            self.imageView.image = UIImage(systemName: "photo")
        }
        
        let url = URL(string: "https://picsum.photos/120/100")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  statusCode == 200 else { return }
            
            guard let imageData = data else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
        
        task.resume()
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
