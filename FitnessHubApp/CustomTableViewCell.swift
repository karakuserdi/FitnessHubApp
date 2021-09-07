//
//  CustomTableViewCell.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 25.08.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var workoutPlan: WorkoutPlann?{
        didSet{
            if let imageData = workoutPlan?.imageData {
                programImageView.image = UIImage(data: imageData)
            }
            
            if let title = workoutPlan?.title, let level = workoutPlan?.level, let type = workoutPlan?.type {
                titleLabel.text = title
                levelLabel.text = level
                typeLabel.text = type
            }

        }
    }
    
    
    static let identifier = "CustomTableViewCell"
    
    private let programImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "demoImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGreen
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(programImageView)
        programImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        programImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        programImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        programImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        programImageView.addSubview(levelLabel)
        levelLabel.topAnchor.constraint(equalTo: programImageView.topAnchor, constant: 10).isActive = true
        levelLabel.leadingAnchor.constraint(equalTo: programImageView.leadingAnchor, constant: 10).isActive = true
        
        programImageView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: programImageView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: programImageView.trailingAnchor, constant: -10).isActive = true
        
        programImageView.addSubview(typeLabel)
        typeLabel.bottomAnchor.constraint(equalTo: programImageView.bottomAnchor, constant: -16).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: programImageView.leadingAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
