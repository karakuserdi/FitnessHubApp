//
//  MyExercises+CoreDataProperties.swift
//  
//
//  Created by Riza Erdi Karakus on 27.08.2021.
//
//

import Foundation
import CoreData


extension MyExercises {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyExercises> {
        return NSFetchRequest<MyExercises>(entityName: "MyExercises")
    }

    @NSManaged public var name: String?
    @NSManaged public var workoutDay: String?
    @NSManaged public var workoutplann: WorkoutPlann?
    

}
