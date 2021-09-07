//
//  SelectedArticleViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 16.08.2021.
//

import UIKit
class SelectedArticleViewController: UIViewController {

    static let identifier = "SelectedArticleViewController"

    var selectedTitle = ""
    var selectedArticle = ""
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let imageView = UIImageView()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        imageView.backgroundColor = .secondarySystemBackground
        setupScrollView()
        subtitleLabel.text = selectedArticle
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(imageView)
        let screenSize: CGRect = UIScreen.main.bounds
        imageView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height / 3)
        
        scrollView.addSubview(subtitleLabel)
        subtitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10).isActive = true
        subtitleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20).isActive = true

    
    }
}

