//
//  Models.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 13.08.2021.
//

import Foundation
import UIKit


struct Articles {
    var title: String
    var article: String
    var imageUrl: String
    
    init(keyID: String, dictionary:[String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.article = dictionary["article"] as? String ?? ""
        self.imageUrl = dictionary["photo"] as? String ?? ""
    }
}

struct RandomCentences {
    let title:String
    let author: String
}

// MARK: -Exercises model

struct Exercises {
    var title: String
    let logo: UIImage
    let exercise: [Exercise]
}

struct Exercise{
    var title: String
    let isSelected: Bool
    let exerciseImage: UIImage?
    let exerciseInfo: ExerciseInfo?
}

struct ExerciseInfo {
    var info: [String]?
    let exerciseImages: [UIImage]?
}

class UserWorkoutPlan {
    var name: String?
    var workoutDay: String?
}

