//
//  RecipeProfile.swift
//  OmaniRecipeV1.1
//
//  Created by Zahran on 12/24/18.
//  Copyright © 2018 ITA. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RecipeProfile: NSObject {
    var recipeTitle = ""
    var recipeDescription = ""
    var imageURL = ""
    var ingredients = [Ingredient]()
    var steps = [Step]()
    
    func saveRecipeToFirebase(recipeProfile: RecipeProfile) {
        var ref = DatabaseReference()
        ref = Database.database().reference()
        
        let ingredient = Ingredient()
        let arrIngredients = ingredient.ingredientsDictionary(ingredints: recipeProfile.ingredients)
        let steps = Step()
        let arrSteps = steps.stepsDictionary(steps: recipeProfile.steps)
        
        let recipeDictionary = ["recipeTitle": recipeProfile.recipeTitle,
                                "recipeDescription": recipeProfile.recipeDescription,
                                "imageURL": recipeProfile.imageURL,
                                "ingredients": arrIngredients,
                                "steps": arrSteps] as [String : Any]
        
        ref.child("Recipes").childByAutoId().setValue(recipeDictionary)
    }
}
class Ingredient: NSObject {
    var nameE = ""
    
    func ingredientsDictionary(ingredints: [Ingredient]) -> Array<Any>{
        var arr = [[String:String]]()
        for item in ingredints {
            let dict = ["nameE": item.nameE]
            arr.append(dict)
        }
        return arr
    }
}
class Step: NSObject {
    var nameE = ""
    var imageURL = ""
    
    func stepsDictionary(steps: [Step]) -> Array<Any>{
        var arr = [[String:String]]()
        for item in steps {
            let dict = ["nameE": item.nameE, "imageURL": item.imageURL]
            arr.append(dict)
        }
        return arr
    }
}
