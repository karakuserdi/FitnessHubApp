//
//  ArticlesViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 13.08.2021.
//

import UIKit
import Firebase

class ArticlesViewController: UIViewController {
    var articles = [Articles](){
        didSet{
            tableView.reloadData()
        }
    }
    
    var selectedArticles = [Articles]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ArticlesTableViewCell.self, forCellReuseIdentifier: ArticlesTableViewCell.identifier)
        return tableView
    }()
    
    private let addArticleButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.backgroundColor = .secondarySystemBackground
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        button.addTarget(self, action: #selector(didTapAddArticleButton), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 28
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Articles"
        setUpTableView()
                
        PostServices.shared.fetchAllItems { (allItems) in
        self.articles = allItems
        }
    }
    
    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.backgroundColor = .lightGray
        tableView.addSubview(addArticleButton)
        tableView.rowHeight = 100
        tableView.separatorColor = .lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        if Auth.auth().currentUser?.uid == "MoT1z3D35Kb1D7XP4yptfnZs0y23" {
            tableView.addSubview(addArticleButton)
            addArticleButton.anchor(bottom: tableView.safeAreaLayoutGuide.bottomAnchor, right: tableView.safeAreaLayoutGuide.rightAnchor, paddingBottom: 16, paddingRight: 16,width: 56,height: 56)
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc private func didTapAddArticleButton(){
        let vc = AddArticleViewController()
        vc.title = "Add New Article"
        present(vc, animated: true, completion: nil)
    }

}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            let willDeleteArticle = self.articles[indexPath.row]
            print(willDeleteArticle)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticlesTableViewCell.identifier, for: indexPath) as? ArticlesTableViewCell else {return UITableViewCell()}
        // Configure the cell...
        cell.articles = articles[indexPath.row]
        
        
        //Show images on tableview cell
        if let url = URL(string: articles[indexPath.row].imageUrl) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.imgView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = SelectedArticleViewController()
        vc.selectedTitle = articles[indexPath.row].title
        vc.selectedArticle = articles[indexPath.row].article
        
       if let url = URL(string: articles[indexPath.row].imageUrl) {
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               if let data = data {
                   DispatchQueue.main.async {
                       vc.imageView.image = UIImage(data: data)!
                   }
               }
           }.resume()
       }
        
        vc.title = articles[indexPath.row].title
        navigationController?.navigationBar.tintColor = .label
        self.navigationController?.pushViewController(vc, animated: true)

    }
}


