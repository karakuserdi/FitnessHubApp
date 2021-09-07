//
//  SingleExerciseCollectionViewCell.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 18.08.2021.
//

import UIKit

class SingleExerciseCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "SingleExerciseCollectionViewCell"
    
    let images: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(images)
        images.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        images.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        images.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        images.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
