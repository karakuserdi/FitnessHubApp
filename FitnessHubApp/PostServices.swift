//
//  PostServices.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 16.08.2021.
//


import UIKit
import Firebase

struct  Workout {
    var workoutName: String
    var workoutSub: String
    
    init(keyID: String, dictionary:[String: Any]) {
        self.workoutName = dictionary["Antreman"] as? String ?? ""
        self.workoutSub = dictionary["Antreman2"] as? String ?? ""
    }
}


struct PostServices {
    static var shared = PostServices()
    let ref = Database.database().reference()
    
    var randomCentences = [RandomCentences]()
    
    func fetchSingleWorkoutItem(id: String, completion: @escaping(Workout) -> Void){
        ref.child("exercises").child(id).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let workout = Workout(keyID: id, dictionary: dictionary)
            completion(workout)
            
        }
    }
    
    
    //MARK: - Articles Datas
    func fetchAllItems(completion: @escaping([Articles]) -> Void){
        var allItems = [Articles]()
        
        ref.child("articles").observe(.childAdded) { snapshot in
            fetchSingleItem(id: snapshot.key) { (item) in
                allItems.append(item)
                completion(allItems)
            }
        }
    }
    
    func fetchSingleItem(id: String, completion: @escaping(Articles) -> Void){
        ref.child("articles").child(id).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let articles = Articles(keyID: id, dictionary: dictionary)
            completion(articles)
        }
    }
    
    func uploadArticles(titleText: String, articleText: String, urlString: String){
        let values = ["title": titleText,
                      "article": articleText,
                      "photo": urlString
        ]
        ref.child("articles").childByAutoId().updateChildValues(values)
    }
}


