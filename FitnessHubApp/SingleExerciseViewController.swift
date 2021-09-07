//
//  SingleExerciseViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 18.08.2021.
//

import UIKit

class SingleExerciseViewController: UIViewController {
    
    var data: Exercise?
    var isShowing: Bool = true

    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(SingleExerciseCollectionViewCell.self, forCellWithReuseIdentifier: SingleExerciseCollectionViewCell.identifier)
        view.backgroundColor = .systemBackground
        view.isPagingEnabled = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var pageIndicator: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = .systemPink
        
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        pc.numberOfPages = (data?.exerciseInfo?.exerciseImages!.count)!
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.isEnabled = false
        return pc
    }()
    
    private let exerciseImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let questionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "suggestion"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(didTapQuestionButton), for: .touchUpInside)
        return button
    }()
    
    private let hintView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 0.5
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.text = "HINT"
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    
    private let hintTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpViews()
                
        hintTableView.delegate = self
        hintTableView.dataSource = self
        hintTableView.tableFooterView = UIView()
    }
    
    // MARK: - Private Funcs
    
    private func setUpViews(){
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(pageIndicator)
        pageIndicator.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5).isActive = true
        pageIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        view.addSubview(questionButton)
        questionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        questionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        questionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        questionButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09).isActive = true
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (t) in
            self.setButton(button: self.questionButton, hidden: false)
        }
        
        view.addSubview(hintView)
        hintView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        hintView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        hintView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        hintView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
        
        hintView.addSubview(hintLabel)
        hintLabel.topAnchor.constraint(equalTo: hintView.topAnchor, constant: 10).isActive = true
        hintLabel.leadingAnchor.constraint(equalTo: hintView.leadingAnchor, constant: 10).isActive = true
        hintLabel.trailingAnchor.constraint(equalTo: hintView.trailingAnchor, constant: -10).isActive = true
        hintLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        hintView.addSubview(hintTableView)
        hintTableView.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 10).isActive = true
        hintTableView.leadingAnchor.constraint(equalTo: hintView.leadingAnchor, constant: 10).isActive = true
        hintTableView.trailingAnchor.constraint(equalTo: hintView.trailingAnchor, constant: -10).isActive = true
        hintTableView.bottomAnchor.constraint(equalTo: hintView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 2, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    private func setButton(button: UIButton, hidden: Bool) {
        UIButton.transition(with: button, duration: 1, options: .transitionCrossDissolve, animations: {
            button.isHidden = hidden
        })
    }
    
    // MARK: - Buttons
    
    @objc private func didTapQuestionButton(){
        if isShowing{
            setView(view: collectionView, hidden: true)
            setView(view: hintView, hidden: false)
            isShowing = false
        } else {
            setView(view: collectionView, hidden: false)
            setView(view: hintView, hidden: true)
            isShowing = true
        }
    }
}

// MARK: - Extension

extension SingleExerciseViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.exerciseInfo?.exerciseImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleExerciseCollectionViewCell.identifier, for: indexPath) as! SingleExerciseCollectionViewCell
        cell.images.image = data?.exerciseInfo?.exerciseImages![indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageIndicator.currentPage = indexPath.row
        
    }
    
}


// Tablview
extension SingleExerciseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.exerciseInfo?.info!.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .systemGreen
        cell.textLabel?.text = data?.exerciseInfo?.info![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
