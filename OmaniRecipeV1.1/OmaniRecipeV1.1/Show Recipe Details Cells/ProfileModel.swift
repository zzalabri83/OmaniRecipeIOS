//
//  ProfileModel.swift
//  TableViewWithMultipleCellTypes
//
//  Created by Stanislav Ostrovskiy on 4/25/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class Profile {
    var recipeName: String?
    var imageURL: String?
    //var email: String?
    var about: String?
    var ingredients = [Ingredient]()
    var steps = [Step]()
    var ref = DatabaseReference()
    init?(recipeProfile: RecipeProfile) {
        self.recipeName = recipeProfile.recipeTitle
        self.about = recipeProfile.recipeDescription
        self.imageURL = "Balloon" //recipeProfile.imageURL
        self.ingredients = recipeProfile.ingredients
        self.steps = recipeProfile.steps
    }
}

class Ingredient: NSObject {
    var nameE: String?
    var amount: String?
    
    init(dict: [String: Any]) {
        self.nameE = dict["nameE"] as? String
        self.amount = dict["amountE"] as? String
    }
    
    func ingredientsDictionary(ingredints: [Ingredient]) -> Array<Any>{
        var arr = [[String:String]]()
        for item in ingredints {
            let dict = ["nameE": item.nameE]
            arr.append(dict as! [String : String])
        }
        return arr
    }
}

class Step: NSObject {
    var nameE: String?
    var imageURL: String?
    
    init(dict: [String: Any]) {
        self.nameE = dict["nameE"] as? String
        self.imageURL = "Balloon" //dict["imageURL"] as? String
    }
    
    func stepsDictionary(steps: [Step]) -> Array<Any>{
        var arr = [[String:String]]()
        for item in steps {
            let dict = ["nameE": item.nameE, "imageURL": item.imageURL]
            arr.append(dict as! [String : String])
        }
        return arr
    }
}

