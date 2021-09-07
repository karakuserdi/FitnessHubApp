//
//  ExercisesTableViewCell.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 17.08.2021.
//

import UIKit

class ExercisesTableViewCell: UITableViewCell {
    
    static let identifier = "ExercisesTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let exercisesImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 35
        image.image = UIImage(named: "logo")
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(exercisesImageView)
        contentView.addSubview(titleLabel)
        
        exercisesImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        exercisesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        exercisesImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        exercisesImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: exercisesImageView.trailingAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
