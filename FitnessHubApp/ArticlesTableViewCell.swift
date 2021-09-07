//
//  ArticlesTableViewCell.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 16.08.2021.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell{
    static let identifier = "ArticlesTableViewCell"
    
    var articles: Articles? {
        didSet{
            titleLabel.text = articles?.title
            article.text = articles?.article
        }
    }
    
    // MARK: - Properties
    let imgView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .label
        label.text = "test"
        
        return label
    }()
    
    private let article: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .label
        label.text = "article"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor, multiplier: 16/9).isActive = true
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 10
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: imgView.rightAnchor,right: rightAnchor, paddingTop: 10, paddingLeft: 8,paddingRight: 30)
        
        addSubview(article)
        article.anchor(top: titleLabel.bottomAnchor, left: imgView.rightAnchor,right: rightAnchor, paddingTop: 4,paddingLeft: 8,paddingRight: 30)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
