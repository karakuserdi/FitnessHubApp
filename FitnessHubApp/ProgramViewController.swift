//
//  ProgramViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 27.08.2021.
//

import UIKit
import CoreData
import Firebase

//struct Exercisee {
//    let name: String
//    let workoutDay: String
//}

class ProgramViewController: UITableViewController, CreateProgramViewControllerDelegate{
    func didTapSaveButton(exercises: MyExercises) {
        self.exercises.append(exercises)
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    var workoutPlan: WorkoutPlann?
    var exercises = [MyExercises]()
    var allExercises = [[MyExercises]]()
    var currentUser = Auth.auth().currentUser
    
    private let addToAsAUserProgramButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.backgroundColor = .secondarySystemBackground
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        button.addTarget(self, action: #selector(didTapAddProfileImageButton), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 28
        return button
    }()
    
    @objc private func didTapAddProfileImageButton(){
        guard let workoutplanExercises = workoutPlan?.myexercises?.allObjects as? [MyExercises] else {return}
        let db = Firebase.Database.database()
        db.reference().child("users/" + self.currentUser!.uid).child("myWorkout").removeValue()
        for myExercise in workoutplanExercises {
            db.reference().child("users/" + self.currentUser!.uid).child("myWorkout").childByAutoId().setValue(["name": myExercise.name, "workoutDay": myExercise.workoutDay])
        }
        
        let alert = UIAlertController(title: "Good News", message: "You selected plan has been added to your plan list.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
        
    private func fetchExercises(){
        guard let workoutplanExercises = workoutPlan?.myexercises?.allObjects as? [MyExercises] else {return}
        
        
        let day1 = workoutplanExercises.filter { (exercise) -> Bool in
            return exercise.workoutDay == "Day 1"
        }
        let day2 = workoutplanExercises.filter { (exercise) -> Bool in
            return exercise.workoutDay == "Day 2"
        }
        let day3 = workoutplanExercises.filter { (exercise) -> Bool in
            return exercise.workoutDay == "Day 3"
        }
        let day4 = workoutplanExercises.filter { (exercise) -> Bool in
            return exercise.workoutDay == "Day 4"
        }
        let day5 = workoutplanExercises.filter { (exercise) -> Bool in
            return exercise.workoutDay == "Day 5"
        }
        let day6 = workoutplanExercises.filter { (exercise) -> Bool in
            return exercise.workoutDay == "Day 6"
        }
        let day7 = workoutplanExercises.filter { (exercise) -> Bool in
            return exercise.workoutDay == "Day 7"
        }
        
        // MARK: - TODO Get name's from cora data and pass it to firebase for users workout plan !!!
        
        allExercises = [day1,day2,day3,day4,day5,day6,day7]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = workoutPlan?.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchExercises()
        setUpBackBurron()
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem?.tintColor = .label
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        
        // Button set up
        tableView.addSubview(addToAsAUserProgramButton)
        addToAsAUserProgramButton.anchor(bottom: tableView.safeAreaLayoutGuide.bottomAnchor, right: tableView.safeAreaLayoutGuide.rightAnchor, paddingBottom: 16, paddingRight: 16,width: 56,height: 56)
    }
    
    @objc func didTapAddButton(){
        let vc = CreateProgramViewController()
        let navCont = UINavigationController(rootViewController: vc)
        vc.delegate = self
        vc.workoutPlan = self.workoutPlan
        navCont.modalPresentationStyle = .fullScreen
        present(navCont, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allExercises[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let exercise = allExercises[indexPath.section][indexPath.row]
        cell.textLabel?.text = exercise.name
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allExercises.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let color = UIColor(red: 250/255, green: 125/255, blue: 125/255, alpha: 1)
        label.backgroundColor = color
        label.textAlignment = .center
        label.textColor = .systemBackground
        label.font = .boldSystemFont(ofSize: 15)
        if section == 0{
            label.text = "Day 1"
        } else if section == 1{
            label.text = "Day 2"
        } else if section == 2{
            label.text = "Day 3"
        } else if section == 3{
            label.text = "Day 4"
        } else if section == 4{
            label.text = "Day 5"
        } else if section == 5{
            label.text = "Day 6"
        } else if section == 6{
            label.text = "Day 7"
        }
        return label
    }
    

}
