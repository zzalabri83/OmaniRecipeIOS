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
    
    func saveRecipeToFirebase(recipeProfile: RecipeProfile) -> String {
        //var recipeID: String?
        var ref = DatabaseReference()
        ref = Database.database().reference()
        
        
        let arrIngredients = ingredients[0].ingredientsDictionary(ingredints: recipeProfile.ingredients)
        let arrSteps = steps[0].stepsDictionary(steps: recipeProfile.steps)

        let recipeDictionary = ["recipeTitle": recipeProfile.recipeTitle,
                                "recipeDescription": recipeProfile.recipeDescription,
                                "imageURL": recipeProfile.imageURL,
                                "ingredients": arrIngredients,
                                "steps": arrSteps] as [String : Any]

        //recipeID =
        if let recipeID = ref.child("recipes").childByAutoId().key {
            ref.child("recipes").child(recipeID).setValue(recipeDictionary)
            return recipeID
        }
        return ""
    }
}
