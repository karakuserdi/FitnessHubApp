//
//  AddArticleViewController.swift
//  fitness
//
//  Created by Riza Erdi Karakus on 4.08.2021.
//

import UIKit
import FirebaseStorage

class AddArticleViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private let storageRef = Storage.storage().reference()
    var selectedPhoto = ""
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .label
        label.text = "Create a New Article"
        label.textAlignment = .center
        return label
    }()
    
    private let titleTextField: UITextField = {
        let title = UITextField()
        title.font = .systemFont(ofSize: 15)
        title.textColor = .label
        title.placeholder = "Enter a New Title"
        title.layer.borderWidth = 0.5
        title.layer.borderColor = UIColor.systemGray.cgColor
        title.layer.cornerRadius = 10
        title.clipsToBounds = true
        return title
    }()
    
    private let articleTextField: UITextField = {
        let title = UITextField()
        title.font = .systemFont(ofSize: 15)
        title.textColor = .label
        title.placeholder = "Enter a New Article"
        title.layer.borderWidth = 0.5
        title.layer.borderColor = UIColor.systemGray.cgColor
        title.layer.cornerRadius = 10
        title.clipsToBounds = true
        return title
    }()
    
    // İmage selection
    let imgView = UIImageView()
    
    @objc func addImage(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    lazy var addImageBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Set Image", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        return button
    }()
    
    lazy var addArticleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Article", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(addArticle), for: .touchUpInside)
        button.layer.cornerRadius = 50/2
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        return button
    }()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        DispatchQueue.main.async {
            let image = UIImage(named: "logo")
            self.imgView.image = image
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Selector
    @objc func addArticle(){
        guard let title = titleTextField.text else {return}
        guard let article = articleTextField.text else {return}
        PostServices.shared.uploadArticles(titleText: title, articleText: article, urlString: selectedPhoto)
        self.dismiss(animated: true, completion: nil)
    }
    
    // Select photo with pickerview and upload and donwload this photo to firebase
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let imageData = image.pngData() else {return}
        
        let random = String.randomString()
        
        storageRef.child("images/\(random).png").putData(imageData, metadata: nil, completion: { _,err in
            guard err == nil else {
                print("Failed")
                return
            }
            self.storageRef.child("images/\(random).png").downloadURL(completion: {url, err in
                guard let url = url, err == nil else {
                    return
                }
                
                let urlString = url.absoluteString
                //UserDefaults.standard.setValue(urlString, forKey: "url")
                
                DispatchQueue.main.async {
                    self.imgView.image = image
                }
                
                self.selectedPhoto = urlString
            })
        })
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - configureView
    func configureView(){
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 16,paddingLeft: 16,paddingRight: 16, height: 50)
    
        view.addSubview(titleTextField)
        titleTextField.anchor(top: titleLabel.bottomAnchor,left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16,paddingRight: 16, height: 50)
        titleTextField.delegate = self
        
        view.addSubview(articleTextField)
        articleTextField.anchor(top: titleTextField.bottomAnchor,left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 16,paddingRight: 16, height: 50)
        articleTextField.delegate = self
         
        view.addSubview(imgView)
        imgView.anchor(top: articleTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor ,paddingTop: 16,paddingLeft: 16,paddingRight: 16,height: view.height/4)
        imgView.contentMode = .scaleAspectFit

        view.addSubview(addImageBtn)
        addImageBtn.anchor(top: imgView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingTop: 16,paddingLeft: 50,paddingRight: 50,height: 40)
        
        view.addSubview(addArticleButton)
        addArticleButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingLeft: 16,paddingBottom: 16,paddingRight: 16,height: 50)
        view.backgroundColor = .systemBackground
    }
}

extension AddArticleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
