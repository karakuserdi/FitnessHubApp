//
//  CreateWorkoutPlanViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 26.08.2021.
//

import UIKit
import CoreData


// custom delegate
protocol CreateWorkoutPlanViewControllerDelegate {
    func didAddWorkoutPlan(workoutPlan: WorkoutPlann)
}

class CreateWorkoutPlanViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate: CreateWorkoutPlanViewControllerDelegate?
    let levelPickerData = ["Select Level","Beginner Level","Elementary Level","Intermediate Level","Advanced Level","Prodicient Level"]
    let typePickerData = ["Select Type","Strength","Power","Flexibility","Cardio", "Balance"]
    var selectedLevelData: String?
    var selectedTypeData: String?
        
    lazy var programImageView: UIImageView = {
        //let image = UIImageView(image: UIImage(named: "select_photo_empty"))
        let image = UIImageView()
        image.backgroundColor = .systemGray
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 20
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhotoSelector)))
        return image
    }()
    
    private let imageLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Image!"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc private func handlePhotoSelector(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            programImageView.image = originalImage
        }
        imageLabel.isHidden = true
        dismiss(animated: true, completion: nil)
        
    }
    
    let titleTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter a title"
        text.autocorrectionType = .no
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 0.2
        text.layer.borderColor = UIColor.label.cgColor
        return text
    }()
    
    let levelTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Select Level"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 0.2
        text.layer.borderColor = UIColor.label.cgColor
        return text
    }()
    
    let typeTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Select Type"
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 0.2
        text.layer.borderColor = UIColor.label.cgColor
        return text
    }()

    let levelPicker = UIPickerView()
    let typePicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Create Workout Plan"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveButton))
        
        levelPicker.dataSource = self
        levelPicker.delegate = self
        typePicker.dataSource = self
        typePicker.delegate = self
        
        levelPicker.tag = 0
        typePicker.tag = 1
        
        levelTextField.inputView = levelPicker
        typeTextField.inputView = typePicker
        
        setupUI()

    }
    
    @objc func handleCancelButton(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSaveButton(){
        
        let context = CoreDataManager.shared.persistentContaine.viewContext
        
        let workoutPlann = NSEntityDescription.insertNewObject(forEntityName: "WorkoutPlann", into: context)
        
        //Get data from user
        guard let title = self.titleTextField.text else {return}
        workoutPlann.setValue(title, forKey: "title")
        
        if let image = programImageView.image {
            let imageData = image.jpegData(compressionQuality: 0.7)
            workoutPlann.setValue(imageData, forKey: "imageData")
        }
        
        if selectedLevelData == "Selection" || selectedLevelData == nil || selectedTypeData == "Selection" || selectedTypeData == nil { return }
        
        workoutPlann.setValue(selectedLevelData, forKey: "level")
        workoutPlann.setValue(selectedTypeData, forKey: "type")
        
        // perfome to save
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didAddWorkoutPlan(workoutPlan: workoutPlann as! WorkoutPlann)
            }
        } catch let saveErr {
            print("Failed to save plan: \(saveErr)")
        }
        
    }
    
    private func setupUI(){
        // setup backgorund color
        setUpBackGroundView(height: 350)
        
        view.addSubview(programImageView)
        programImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        programImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        programImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        programImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        programImageView.addSubview(imageLabel)
        imageLabel.centerXAnchor.constraint(equalTo: programImageView.centerXAnchor).isActive = true
        imageLabel.centerYAnchor.constraint(equalTo: programImageView.centerYAnchor).isActive = true

        view.addSubview(titleTextField)
        titleTextField.topAnchor.constraint(equalTo: programImageView.bottomAnchor, constant: 10).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(levelTextField)
        levelTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10).isActive = true
        levelTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        levelTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        levelTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(typeTextField)
        typeTextField.topAnchor.constraint(equalTo: levelTextField.bottomAnchor, constant: 10).isActive = true
        typeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        typeTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        typeTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension CreateWorkoutPlanViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return levelPickerData.count
        case 1:
            return typePickerData.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return levelPickerData[row]
        case 1:
            return typePickerData[row]
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            levelTextField.text = levelPickerData[row]
            if levelTextField.text == "Select Level" {
                levelTextField.text = ""
            }
            selectedLevelData = levelTextField.text
            levelTextField.resignFirstResponder()
        case 1:
            typeTextField.text = typePickerData[row]
            if typeTextField.text == "Select Type" {
                typeTextField.text = ""
            }
            selectedTypeData = typeTextField.text
            typeTextField.resignFirstResponder()
        default:
            break
        }
    }
}
