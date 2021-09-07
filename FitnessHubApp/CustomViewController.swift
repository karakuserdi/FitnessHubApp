//
//  CustomViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 25.08.2021.
//

import UIKit
import CoreData

class CustomViewController: UIViewController, CreateWorkoutPlanViewControllerDelegate {
    func didAddWorkoutPlan(workoutPlan: WorkoutPlann) {
        workoutPlans.append(workoutPlan)
        let newIndexPath = IndexPath(row: workoutPlans.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    var workoutPlans = [WorkoutPlann]()
    let context = CoreDataManager.shared.persistentContaine.viewContext

    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.workoutPlans = CoreDataManager.shared.fetchData()
        
        navigationItem.title = "Workout Plans"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem?.tintColor = .label
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.tableFooterView = UIView()
    }
    
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc private func didTapAddButton(){
        let vc = CreateWorkoutPlanViewController()
        let navCont = UINavigationController(rootViewController: vc)
        navCont.modalPresentationStyle = .fullScreen
        vc.delegate = self
        present(navCont, animated: true, completion: nil)
    }
}

extension CustomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            let willDeletePlan = self.workoutPlans[indexPath.row]
            self.context.delete(willDeletePlan)
            do {
                try self.context.save()
            } catch let fatalError {
                print("Failed to delete data: \(fatalError)")
            }
            self.workoutPlans = CoreDataManager.shared.fetchData()
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutPlans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        let workoutplans = workoutPlans[indexPath.row]
        
        cell.workoutPlan = workoutplans
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "There is no any workout plan"
        label.textColor = .label
        label.textAlignment = .center
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return workoutPlans.count == 0 ? 150 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let workoutPlan = workoutPlans[indexPath.row]
        let vc = ProgramViewController()
        vc.workoutPlan = workoutPlan
        let navCont = UINavigationController(rootViewController: vc)
        navCont.modalPresentationStyle = .fullScreen
        present(navCont, animated: true, completion: nil)
    }
}
