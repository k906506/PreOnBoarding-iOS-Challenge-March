//
//  CustomImageViewController.swift
//  PreOnBoarding-iOS-Challenge-March
//
//  Created by 고도 on 2023/02/26.
//

import UIKit

class CustomImageViewController: UIViewController {
    private let numberOfItems = 5
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CustomImageCellView.self, forCellWithReuseIdentifier: "CustomImageCellView")

        
        return collectionView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Load All Images"
        configuration.cornerStyle = .medium
        
        button.configuration = configuration
        button.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    @objc private func loadButtonTapped(_ sender: UIButton) {
        for idx in 0..<numberOfItems {
            guard let cell = collectionView.cellForItem(at: IndexPath(row: idx, section: 0)) as? CustomImageCellView else { return }
            
            cell.loadButtonTapped(sender)
        }
    }
}

private extension CustomImageViewController {
    func setupLayout() {
        [collectionView, button].forEach { self.view.addSubview($0) }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false // AutoLayout을 사용하기 위한 설정
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
    }
}

// cell과 보여줄 cell의 개수를 설정하기 위한 Datasource
extension CustomImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomImageCellView", for: indexPath) as? CustomImageCellView else { return UICollectionViewCell() }
        
        return cell
    }
}

// cell의 frame을 설정하기 위한 Delegate
extension CustomImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 16 // collectionView의 leading, traling padding을 제거한 width
        let height = (collectionView.frame.height - 40) / CGFloat(numberOfItems) // 각 cell의 top, bottom padding을 제거한 height
        
        return CGSize(width: width, height: height)
    }
}
