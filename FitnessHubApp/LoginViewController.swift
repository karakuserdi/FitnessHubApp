//
//  LoginViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 13.08.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let emailField: UITextField = {
        let field =  UITextField()
        field.placeholder = "Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    
    private let passwordField: UITextField = {
        let field =  UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let newAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create a New Account !", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        newAccountButton.addTarget(self, action: #selector(didTapNewAccount), for: .touchUpInside)
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(newAccountButton)

      
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 100, width: view.width-40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width-40, height: 52)
        loginButton.frame = CGRect(x: 20, y: passwordField.bottom + 10, width: view.width-40, height: 52)
        newAccountButton.frame = CGRect(x: 20, y: loginButton.bottom + 10, width: view.width-40, height: 52)

    }
    
    @objc private func didTapLoginButton(){
        let email = emailField.text!
        let password = passwordField.text!
                
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed: break
                case .userDisabled: break
                case .wrongPassword: break
                case .invalidEmail: break
                default:
                    print("Error: \(error.localizedDescription)")
                }
        } else {
            self.dismiss(animated: true, completion: nil)
            print("User signs up successfully")
            let newUserInfo = Auth.auth().currentUser
            let email = newUserInfo?.email
            print(email as Any)
          }
        }
    }
    
    @objc private func didTapNewAccount(){
        let vc = RegisterViewController()
        vc.title = "Create Account"
        present(vc, animated: true, completion: nil)
    }

}
