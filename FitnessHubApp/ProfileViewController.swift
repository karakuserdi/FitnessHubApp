//
//  ProfileViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 13.08.2021.
//

import UIKit
import Firebase
import SDWebImage


class ProfileViewController: UIViewController {
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .secondarySystemBackground
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.systemBlue.cgColor
        image.layer.borderWidth = 3
        return image
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let firstAndLastNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let infoView : UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let phoneNumberLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .secondarySystemBackground
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()
    
    let emailLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .secondarySystemBackground
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()
    
    let registerDateLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .secondarySystemBackground
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()
    
    let randomMessageLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .secondarySystemBackground
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .systemIndigo
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (t) in
            self.removeSpinner()
        }
        
        self.navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapGearButton))
        
        navigationItem.rightBarButtonItem?.tintColor = .label
        // Do any additional setup after loading the view.
        setUpProfileElements()
        
        randomMessageLabel.text = "   \(LocalDataServices.shared.localDatas().title) \n\n     \(LocalDataServices.shared.localDatas().author)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.setUserInfos()
        }
    }
    
    private func setUserInfos(){
        let ref = Database.database().reference()
        let user = Auth.auth().currentUser
        ref.child("users/"+user!.uid).getData{ (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                let value = snapshot.value as? NSDictionary
                
                let username = value?["username"] as? String ?? ""
                let firstAndLastName = value?["firstAndLastName"] as? String ?? ""
                let phone = value?["phone"] as? String ?? ""
                let email = value?["email"] as? String ?? ""
                let registerDate = value?["registerDate"] as? String ?? ""
                let photo = value?["photo"] as? String ?? ""
                let url = URL(string: photo)

                self.phoneNumberLabel.text = "  Phone Number: \(phone)"
                self.firstAndLastNameLabel.text = firstAndLastName
                self.emailLabel.text = "  Email: \(email)"
                self.userNameLabel.text = "@\(username)"
                self.profileImageView.sd_setImage(with: url, completed: nil)
                self.registerDateLabel.text = "  Register Date: \(registerDate)"
            }
            else {
                print("No data available")
            }
        }
    }
    
    
    
    private func setUpProfileElements(){
        view.addSubview(profileImageView)
        let imageSize = view.width/2.5
        profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        profileImageView.layer.cornerRadius = imageSize/2
        
        view.addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        userNameLabel.widthAnchor.constraint(equalToConstant: imageSize*1.5).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

        view.addSubview(firstAndLastNameLabel)
        firstAndLastNameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5).isActive = true
        firstAndLastNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        firstAndLastNameLabel.widthAnchor.constraint(equalToConstant: imageSize*1.5).isActive = true
        firstAndLastNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.topAnchor.constraint(equalTo: firstAndLastNameLabel.bottomAnchor, constant: 10).isActive = true
        infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
        infoView.addSubview(phoneNumberLabel)
        infoView.addSubview(emailLabel)
        infoView.addSubview(registerDateLabel)
        infoView.addSubview(randomMessageLabel)
        
        let viewSize = view.height/3
        phoneNumberLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 5).isActive = true
        phoneNumberLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 5).isActive = true
        phoneNumberLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -5).isActive = true
        phoneNumberLabel.heightAnchor.constraint(equalToConstant: viewSize/6).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 5).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 5).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -5).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: viewSize/6).isActive = true

        
        registerDateLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
        registerDateLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 5).isActive = true
        registerDateLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -5).isActive = true
        registerDateLabel.heightAnchor.constraint(equalToConstant: viewSize/6).isActive = true
        
        randomMessageLabel.topAnchor.constraint(equalTo: registerDateLabel.bottomAnchor, constant: 5).isActive = true
        randomMessageLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 5).isActive = true
        randomMessageLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -5).isActive = true
        randomMessageLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -5).isActive = true

    }
    
    @objc private func didTapGearButton(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.navigationBar.tintColor = .label
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
