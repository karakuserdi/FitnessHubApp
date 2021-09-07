//
//  EditProfileViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 13.08.2021.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var currentUser = Auth.auth().currentUser
    var selectedPhoto = ""
    
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

    private let lineView = UIView()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let firstAndLastNameText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderColor = UIColor.systemGray.cgColor
        text.layer.borderWidth = 0.5
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 5
        text.autocorrectionType = .no
        return text
    }()
    
    let massTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderColor = UIColor.systemGray.cgColor
        text.layer.borderWidth = 0.5
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 5
        text.autocorrectionType = .no
        text.placeholder = "Kilonuzu Giriniz"
        text.font = .systemFont(ofSize: 15)
        return text
    }()
    
    let sizeTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderColor = UIColor.systemGray.cgColor
        text.layer.borderWidth = 0.5
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 5
        text.autocorrectionType = .no
        text.placeholder = "Boyunuzu Giriniz"
        text.font = .systemFont(ofSize: 15)
        return text
    }()
    
    let infoView : UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let phoneNumberText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderColor = UIColor.systemGray.cgColor
        text.layer.borderWidth = 0.5
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 5
        text.autocorrectionType = .no
        return text
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
    
    let bmiCalculator : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .secondarySystemBackground
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.text = "BMI Calculator"
        label.textAlignment = .center
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
    
    private let addProfileImageButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.backgroundColor = .secondarySystemBackground
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        button.addTarget(self, action: #selector(didTapAddProfileImageButton), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 28
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.systemBlue.cgColor
        return button
    }()
    
    private let bmiCalculateButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.backgroundColor = .red
        button.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        button.addTarget(self, action: #selector(didTapCalculateButton), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.setTitle("Calculate", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { (t) in
            self.removeSpinner()
        }
        phoneNumberText.delegate = self
        firstAndLastNameText.delegate = self
        massTextField.delegate = self
        sizeTextField.delegate = self
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem?.tintColor = .label
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        setUpProfileElements()
        
        view.addSubview(addProfileImageButton)
        addProfileImageButton.anchor(bottom: profileImageView.bottomAnchor, right: profileImageView.rightAnchor, paddingBottom: 10, paddingRight: 10,width: 56,height: 56)
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.getUserInfo()
        }
    }
    
    private func calculateBmi(mass: Double, height: Double) -> String {
        let bmi = (mass / (height * 2)) * 100
        let bmiText: String = String(format: "%.2f", bmi)

        switch bmi {
        case 0..<18.5:
            return ("Your bmi is \(bmiText) therefore you are underweight")
        case 18.5..<24.99:
            return ("Your bmi is \(bmiText) therefore you are of normal weight")
        case 25..<29.99:
            return ("Your bmi is \(bmiText) therefore you are overweight")
        case 30..<34.99:
            return ("Your bmi is \(bmiText) therefore you are Obesity (Class 1)")
        case 35..<39.99:
            return ("Your bmi is \(bmiText) therefore you are Obesity (Class 2)")
        case 40...:
            return ("Your bmi is \(bmiText) therefore you are Morbid Obesity")
        default:
            return ""
        }
    }
    
    @objc private func didTapCalculateButton(){
        if let mass = Double(massTextField.text!) {
            if let size = Double(sizeTextField.text!) {
                let bmiS = calculateBmi(mass: mass, height: size)
                alertMessage(message: bmiS)
                massTextField.text = ""
                sizeTextField.text = ""
            }
        }
    }
    
    private func alertMessage(message: String){
        let bmiMessage = UIAlertController(title: "BMI", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        bmiMessage.addAction(ok)
        self.present(bmiMessage, animated: true, completion: nil)
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

        view.addSubview(firstAndLastNameText)
        firstAndLastNameText.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5).isActive = true
        firstAndLastNameText.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        firstAndLastNameText.widthAnchor.constraint(equalToConstant: imageSize*1.5).isActive = true
        firstAndLastNameText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.topAnchor.constraint(equalTo: firstAndLastNameText.bottomAnchor, constant: 10).isActive = true
        infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
        infoView.addSubview(phoneNumberText)
        infoView.addSubview(emailLabel)
        infoView.addSubview(registerDateLabel)
        infoView.addSubview(bmiCalculator)
        infoView.addSubview(massTextField)
        infoView.addSubview(sizeTextField)
        infoView.addSubview(bmiCalculateButton)
        infoView.addSubview(lineView)

        let viewSize = view.height/3
        let viewWidth = view.width/3
        phoneNumberText.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 5).isActive = true
        phoneNumberText.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 5).isActive = true
        phoneNumberText.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -5).isActive = true
        phoneNumberText.heightAnchor.constraint(equalToConstant: viewSize/6).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: phoneNumberText.bottomAnchor, constant: 5).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 5).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -5).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: viewSize/6).isActive = true

        
        registerDateLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
        registerDateLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 5).isActive = true
        registerDateLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -5).isActive = true
        registerDateLabel.heightAnchor.constraint(equalToConstant: viewSize/6).isActive = true
        
        
        //Seperator
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: registerDateLabel.bottomAnchor, constant: 15).isActive = true
        lineView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 0).isActive = true
        lineView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.backgroundColor = .lightGray

        bmiCalculator.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 15).isActive = true
        bmiCalculator.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 5).isActive = true
        bmiCalculator.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -5).isActive = true
        bmiCalculator.heightAnchor.constraint(equalToConstant: viewSize/6).isActive = true
        
        massTextField.topAnchor.constraint(equalTo: bmiCalculator.bottomAnchor, constant: 5).isActive = true
        massTextField.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 5).isActive = true
        massTextField.heightAnchor.constraint(equalToConstant: viewSize/6).isActive = true
        massTextField.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        
        sizeTextField.topAnchor.constraint(equalTo: bmiCalculator.bottomAnchor, constant: 5).isActive = true
        sizeTextField.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -5).isActive = true
        sizeTextField.heightAnchor.constraint(equalToConstant: viewSize/6).isActive = true
        sizeTextField.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        
        bmiCalculateButton.topAnchor.constraint(equalTo: sizeTextField.bottomAnchor, constant: 5).isActive = true
        bmiCalculateButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 5).isActive = true
        bmiCalculateButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -5).isActive = true
        bmiCalculateButton.heightAnchor.constraint(equalToConstant: viewSize/6).isActive = true

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let imageData = image.pngData() else {return}
        
        let random = String.randomString()
        let storageRef = Storage.storage().reference()
        storageRef.child("profileImages/\(random).png").putData(imageData, metadata: nil, completion: { _,err in
            guard err == nil else {
                print("Failed")
                return
            }
            storageRef.child("profileImages/\(random).png").downloadURL(completion: {url, err in
                guard let url = url, err == nil else {
                    return
                }
                
                let urlString = url.absoluteString
                
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
                self.selectedPhoto = urlString
            })
        })
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapSaveButton(){
        let actionSheed = UIAlertController(title: "Save All", message: "Do you wants save infos ?", preferredStyle: .actionSheet)
        actionSheed.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheed.addAction(UIAlertAction(title: "Save", style: .destructive) { _ in
                let name = self.firstAndLastNameText.text!
                let phone = self.phoneNumberText.text!
            if name.isEmpty ||  phone.isEmpty || self.selectedPhoto.isEmpty{
                print("failed to save")
                return
            } else {
                let values = ["firstAndLastName": name, "phone" : phone, "photo": self.selectedPhoto]
                let db = Firebase.Database.database()
                db.reference().child("users/" + self.currentUser!.uid).updateChildValues(values)
            _ = self.navigationController?.popToRootViewController(animated: true)
            }
        })
        present(actionSheed, animated: true, completion: nil)
    }
    
    @objc private func didTapAddProfileImageButton(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberText {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        } else if textField == firstAndLastNameText{
            let allowedCharacters = CharacterSet(charactersIn:"qwertyuıopğüasdfghjklşizxcvbnmöçQWERTYUIOPĞÜASDFGHJKLŞİZXCVBNMÖÇ ")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        } else if textField == massTextField || textField == sizeTextField{
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    private func getUserInfo(){
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

                self.phoneNumberText.placeholder = "Phone Number: \(phone)"
                if firstAndLastName.isEmpty{
                    self.firstAndLastNameText.placeholder = "  Enter a name and surname"
                } else {
                    self.firstAndLastNameText.placeholder = firstAndLastName
                }
                
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
}
