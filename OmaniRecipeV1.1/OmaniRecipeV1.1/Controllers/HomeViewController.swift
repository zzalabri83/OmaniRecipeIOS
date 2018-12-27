//
//  HomeViewController.swift
//  AKSideMenuSimple
//
//  Created by Diogo Autilio on 6/6/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

public class HomeViewController: UIViewController {

    var ref = DatabaseReference()
    var recipeProfile = RecipeProfile()
    
    @IBAction func btnGoNext(_ sender: Any) {
        
        self.performSegue(withIdentifier: "recipeDetails", sender: nil)
        
    }
    @IBAction func btnAddRecipe(_ sender: Any) {
        self.performSegue(withIdentifier: "addRecipe", sender: nil)
    }
    @IBAction func btnRecipeClipper(_ sender: Any) {
        self.performSegue(withIdentifier: "recipeClipper", sender: nil)
    }
    @IBAction func btnShowRecipe(_ sender: Any) {
        self.performSegue(withIdentifier: "recipeDetails", sender: nil)
    }
    
    fileprivate func getDataFromFirebase() {
        let recipeID = "-LUeZuNajSxtfV0LQThB"
        ref = Database.database().reference()
        if (Auth.auth().currentUser?.uid) != nil {
            ref.child("recipes").child(recipeID).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                //DispatchQueue.main.sync() {
                let recipeData = snapshot.value as? [String : AnyObject] ?? [:]
                if let title = recipeData["recipeTitle"] as? String {
                    self.recipeProfile.recipeTitle = title
                    print(self.recipeProfile.recipeTitle)
                }
                self.recipeProfile.recipeDescription = (recipeData["recipeDescription"] as? String)!
                self.recipeProfile.imageURL = (recipeData["imageURL"] as? String)!
                if let ingredients = recipeData["ingredients"] as? [[String: Any]] {
                    //self.ingredients = ingredients.map { Ingredient(json: $0) }
                    for ingr in ingredients {
                        self.recipeProfile.ingredients.append(Ingredient(dict: ingr))
                    }
                }
                
                if let steps = recipeData["steps"] as? [[String: Any]] {
                    //self.steps = steps.map { Step(json: $0) }
                    for stp in steps {
                        self.recipeProfile.steps.append(Step(dict: stp))
                    }
                }
                // }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
                if let ShowController = destination as? ShowRecipeDetailsViewController {
                    //locationTableViewController = locationController
                    print(recipeProfile.recipeTitle)
        
                    ShowController.recipeProfile = self.recipeProfile
                    //HomeController.recipeID = self.recipeID
        
                }
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromFirebase()
    }

}
