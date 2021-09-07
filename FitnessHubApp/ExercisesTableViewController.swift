//
//  ExercisesTableViewController.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 18.08.2021.
//

import UIKit

class ExercisesTableViewController: UITableViewController {
    
    var data: Exercises?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ExercisesTableViewCell.self, forCellReuseIdentifier: ExercisesTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        //navigationItem.leftBarButtonItem?.tintColor = .label

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.exercise.count ?? 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExercisesTableViewCell.identifier, for: indexPath) as! ExercisesTableViewCell
        cell.titleLabel.text = data?.exercise[indexPath.row].title
        cell.exercisesImageView.image = data?.exercise[indexPath.row].exerciseImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = SingleExerciseViewController()
        vc.data = self.data?.exercise[indexPath.row]
        vc.title = self.data?.exercise[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}
