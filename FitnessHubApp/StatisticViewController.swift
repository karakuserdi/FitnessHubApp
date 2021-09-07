//
//  StatisticViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 13.08.2021.
//

import UIKit
import Firebase

class StatisticViewController: UIViewController {
    
    var plans = [[UserWorkoutPlan]]()
    var day1 = [UserWorkoutPlan]()
    var day2 = [UserWorkoutPlan]()
    var day3 = [UserWorkoutPlan]()
    var day4 = [UserWorkoutPlan]()
    var day5 = [UserWorkoutPlan]()
    var day6 = [UserWorkoutPlan]()
    var day7 = [UserWorkoutPlan]()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.backgroundColor = .lightGray
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "User Workout Plan"
        setUserInfos()
        tableView.dataSource = self
        tableView.delegate = self
        setUpUI()
        tableView.tableFooterView = UIView()
    }
    
    private func setUpUI(){
        view.addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setUserInfos(){
        let ref = Database.database().reference()
        let user = Auth.auth().currentUser
        ref.child("users/"+user!.uid).child("myWorkout").observe(.value) { [self] (snapshot) in
            if snapshot.value != nil {
                plans.removeAll()
                day1.removeAll()
                day2.removeAll()
                day3.removeAll()
                day4.removeAll()
                day5.removeAll()
                day6.removeAll()
                day7.removeAll()
                
                for child in snapshot.children {
                    let plan = UserWorkoutPlan()
                    let snap = child as! DataSnapshot
                    let userworkout = snap.value as! [String: Any]
                    
                    plan.name = userworkout["name"] as? String
                    plan.workoutDay = userworkout["workoutDay"] as? String
                    
                    if plan.workoutDay == "Day 1"{
                        day1.append(plan)
                    } else if plan.workoutDay == "Day 2"{
                        day2.append(plan)
                    } else if plan.workoutDay == "Day 3"{
                        day3.append(plan)
                    } else if plan.workoutDay == "Day 4"{
                        day4.append(plan)
                    } else if plan.workoutDay == "Day 5"{
                        day5.append(plan)
                    } else if plan.workoutDay == "Day 6"{
                        day6.append(plan)
                    } else if plan.workoutDay == "Day 7"{
                        day7.append(plan)
                    }
                    
                    self.plans = [day1,day2,day3,day4,day5,day6,day7]
                    tableView.reloadData()
                }
            }
        }
        // fetch username from firebase
        ref.child("users/"+user!.uid).getData{ (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                let value = snapshot.value as? NSDictionary
                let username = value?["username"] as? String ?? ""
                self.userNameLabel.text = "\(username)'s workout plan!"
            }
            else {
                print("No data available")
            }
        }
    }
}

extension StatisticViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let myPlan = plans[indexPath.section][indexPath.row]
        cell.textLabel?.text = myPlan.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return plans.count
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
