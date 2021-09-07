//
//  CreateProgramViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 27.08.2021.
//

import UIKit
import CoreData

protocol CreateProgramViewControllerDelegate {
    func didTapSaveButton(exercises: MyExercises)
    
    //dismiss(animated: true, completion: nil)
}

class CreateProgramViewController: UIViewController {
    
    var delegate: CreateProgramViewControllerDelegate?
    
    var workoutPlan: WorkoutPlann?
    
    let bodyPartPickerView = UIPickerView()
    let exercisesTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.masksToBounds = true
        table.layer.cornerRadius = 10
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.allowsMultipleSelection = true
        table.allowsMultipleSelectionDuringEditing = true
        return table
    }()
        
    var exercises: [Exercises]?
    var exercise: [Exercise]?
    var selectedExercises = [String]()

    
    let bodyPartTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Select body part"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 0.2
        text.layer.borderColor = UIColor.label.cgColor
        return text
    }()
    
    let daySegmentedControl: UISegmentedControl = {
        let days = ["Day 1", "Day 2","Day 3","Day 4","Day 5","Day 6", "Day 7"]
        let segment = UISegmentedControl(items: days)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        return segment
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        exercises = LocalDataServices.shared.loadTableViewDatas()
        navigationItem.title = "Add Exercises"
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        setUpBackBurron()
        setUpUI()

        bodyPartPickerView.dataSource = self
        bodyPartPickerView.delegate = self
        bodyPartTextField.inputView = bodyPartPickerView
                
        exercisesTableView.delegate = self
        exercisesTableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(handleDidTapSaveButton))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    @objc func handleDidTapSaveButton(){
        selectedExercises.removeAll()
        
        guard let exercisesDay = daySegmentedControl.titleForSegment(at: daySegmentedControl.selectedSegmentIndex) else {return}
        
        if let selectedRows = exercisesTableView.indexPathsForSelectedRows {
            for index in selectedRows {
                selectedExercises.append(exercise![index.row].title)
            }
            for allSelection in selectedExercises {
                let values = CoreDataManager.shared.createMyExercises(exercisesName: allSelection, workoutDay: exercisesDay, workoutPlan: workoutPlan!)
                if let error = values.1 {
                    print("Error",error)
                } else {
                    dismiss(animated: true) {
                        self.delegate?.didTapSaveButton(exercises: values.0!)
                    }
                }
            }
        }
    }
    
    private func setUpUI(){
        setUpBackGroundView(height: 440)
        
        view.addSubview(bodyPartTextField)
        bodyPartTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        bodyPartTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bodyPartTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bodyPartTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(exercisesTableView)
        exercisesTableView.topAnchor.constraint(equalTo: bodyPartTextField.bottomAnchor, constant: 10).isActive = true
        exercisesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        exercisesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        exercisesTableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        exercisesTableView.tableFooterView = UIView()
        
        view.addSubview(daySegmentedControl)
        daySegmentedControl.topAnchor.constraint(equalTo: exercisesTableView.bottomAnchor, constant: 10).isActive = true
        daySegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        daySegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        daySegmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
}

extension CreateProgramViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exercises!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exercises![row].title
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        exercise = exercises![row].exercise
        exercisesTableView.reloadData()
        bodyPartTextField.text = exercises![row].title
        bodyPartTextField.resignFirstResponder()
    }
}

extension CreateProgramViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercise?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = exercise?[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
