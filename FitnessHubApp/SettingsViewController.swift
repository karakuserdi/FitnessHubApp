//
//  SettingsViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 13.08.2021.
//

import UIKit
import SafariServices
import Firebase

struct SettingsModel {
    let id: Int
    var title: String
    let handler: (() -> Void)
}

final class SettingsViewController: UIViewController {
    
    private var cellData = [[SettingsModel]]()
    
    let defaults = UserDefaults.standard
    private var isDarkMode: Bool = UserDefaults.standard.bool(forKey: "darkMode")

    var darkModeText: String = ""
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if isDarkMode{
            darkModeText = "Light Mode"
            tableView.reloadData()
        }else{
            darkModeText = "Dark Mode"
            tableView.reloadData()
        }
        
        loadSettingsCellData()
        setUpTableView()
        
        view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Private func
    
    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
    }
    
    
    
    private func loadSettingsCellData(){
        cellData.append([
            SettingsModel(id: 0, title: "Edit Profile") { [weak self] in
            self?.didTapEditProfileButton()
        },
            SettingsModel(id: 1, title: "Share With Friends") { [weak self] in
            self?.didTapShareButton()
        },
            SettingsModel(id: 2, title: darkModeText) { [weak self] in
            self?.didTapDarkModeButton()
        }
        ])
        
        cellData.append([
            SettingsModel(id: 3, title: "Terms of Service") { [weak self] in
                self?.openUrl(type: .terms)
            },
            SettingsModel(id: 4, title: "Privacy Policy") { [weak self] in
                self?.openUrl(type: .privacy)
            },
            SettingsModel(id: 5, title: "Help / Feed") { [weak self] in
                self?.openUrl(type: .help)
            }
        ])
        
        cellData.append([SettingsModel(id: 6, title: "Log Out") { [weak self] in
            self?.didTapLogoutButton()
        }
        ])
    }
    
    private func openUrl(type: SettingsURLType){
        let urlString: String
        switch type {
        case .terms: urlString = "https://help.instagram.com/581066165581870"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Buttons
    private func didTapEditProfileButton(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        navigationController?.pushViewController(vc, animated: true)
    }

    
    private func didTapLogoutButton(){
        let actionSheed = UIAlertController(title: "Log Out", message: "Do you want to log out?", preferredStyle: .actionSheet)
        actionSheed.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheed.addAction(UIAlertAction(title: "Log Out", style: .destructive) { _ in
            do {
                try Auth.auth().signOut()
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false) {
                    self.navigationController?.popToRootViewController(animated: false)
                    self.tabBarController?.selectedIndex = 0
                }
                return
            } catch {
                print(error)
                return
            }
        })
        present(actionSheed, animated: true, completion: nil)
    }
    
    private func didTapShareButton(){
        let avtivityVC = UIActivityViewController(activityItems: ["Hey, did you see that app? It's awsome. Let's download it..."], applicationActivities: nil)
        avtivityVC.popoverPresentationController?.sourceView = self.view
        self.present(avtivityVC, animated: true, completion: nil)
    }

    private func didTapDarkModeButton(){
        if !isDarkMode{
            isDarkMode = true
            defaults.setValue(isDarkMode, forKey: "darkMode")
            window.overrideUserInterfaceStyle = .dark
            tableView.reloadData()
        } else {
            isDarkMode = false

            defaults.setValue(isDarkMode, forKey: "darkMode")
            window.overrideUserInterfaceStyle = .light
            tableView.reloadData()
        }
    }
}

// MARK: - Extensions

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cellData[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        cellData[indexPath.section][indexPath.row].handler()
        
        if cellData[indexPath.section][indexPath.row].id == 2 {
            if isDarkMode{
                cellData[indexPath.section][indexPath.row].title = "Dark Mode"
                tableView.reloadData()
            } else {
                cellData[indexPath.section][indexPath.row].title = "Light Mode"
                tableView.reloadData()
            }
        }
    }
}
