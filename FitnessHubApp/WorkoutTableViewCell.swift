//
//  WorkoutTableViewCell.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 18.08.2021.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    var exercise: Exercises?{
        didSet{
            logoView.image = exercise?.logo
            titleLabel.text = exercise?.title
        }
    }
    
    static let identifier = "WorkoutTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let logoView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 35
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(logoView)
        contentView.addSubview(titleLabel)
        
        logoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        logoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

