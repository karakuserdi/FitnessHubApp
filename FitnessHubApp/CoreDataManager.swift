//
//  CoreDataManager.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 26.08.2021.
//

import CoreData

struct CoreDataManager {
    
    // live alive forever
    static let shared = CoreDataManager()
    
    let persistentContaine: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WorkoutPlanModels")
        container.loadPersistentStores { storeDescrpition, err in
            if let err = err {
                fatalError("Loading of store failed: \(err) ")
            }
        }
        return container
    }()
    
    func fetchData() -> [WorkoutPlann]{
        let context = persistentContaine.viewContext
        let fetchRequest = NSFetchRequest<WorkoutPlann>(entityName: "WorkoutPlann")
        do {
            let workoutPlans = try context.fetch(fetchRequest)
            return workoutPlans
            
        } catch let fertchErr {
            print("Failed to fatch data: \(fertchErr)")
            return []
        }
    }
    func createMyExercises(exercisesName: String, workoutDay: String, workoutPlan: WorkoutPlann) -> (MyExercises? ,Error?){
        let context = persistentContaine.viewContext
        
        // create a plan
        let myExercises = NSEntityDescription.insertNewObject(forEntityName: "MyExercises", into: context) as! MyExercises
        
        myExercises.workoutplann = workoutPlan
        myExercises.workoutDay = workoutDay
        
        //create exercise plan
        myExercises.setValue(exercisesName, forKey: "name")
        
        do {
            try context.save()
            return (myExercises, nil)
        } catch let err {
            print("Fattal error: ", err)
            return (nil, err)
        }
        
    }
}
