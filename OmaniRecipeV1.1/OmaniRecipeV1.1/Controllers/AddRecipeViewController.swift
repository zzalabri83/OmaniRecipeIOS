//
//  ViewController.swift
//  TestUITable
//
//  Created by Zahran on 12/22/18.
//  Copyright © 2018 Zahran. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AddRecipeViewController: UIViewController {
    var ref = DatabaseReference()
    var recipeProfile = RecipeProfile()
    var recipeID: String?
    
    var ingredientsArray = [String]()
    var stepsArray = [String]()
    
    @IBOutlet weak var imgRecipe: UIImageView!
    @IBOutlet weak var txtRecipeTitle: UITextField!
    @IBOutlet weak var txtRecipeDescription: UITextField!
    
    @IBOutlet weak var ingredientsContainerView: UIView!
    
    @IBOutlet weak var StepsContainerView: UIView!
    @IBOutlet weak var segmentRecipe: UISegmentedControl!
    
    @IBAction func segementClicked(_ sender: UISegmentedControl) {
        switch segmentRecipe.selectedSegmentIndex {
        case 0:
            ingredientsContainerView.isHidden = false
            StepsContainerView.isHidden = true
        case 1:
            ingredientsContainerView.isHidden = true
            StepsContainerView.isHidden = false
        default:
            print("No extra segement")
        }
    }
    
    fileprivate func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        //alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func btnSaveRecipe(_ sender: Any) {
        
//        let recipeProfile = RecipeProfile()
//
//        for item in ingredientsArray {
//            let ingredients = Ingredient()
//            ingredients.nameE = item
//            recipeProfile.ingredients.append(ingredients)
//        }
//        for item in stepsArray {
//            let steps = Step()
//            steps.nameE = item
//            recipeProfile.steps.append(steps)
//        }
//        if let title = txtRecipeTitle.text {
//            recipeProfile.recipeTitle = title
//        }
//        if let description = txtRecipeDescription.text {
//            recipeProfile.recipeDescription = description
//        }
        recipeProfile.imageURL = "Here is an image"
        
        recipeID = recipeProfile.saveRecipeToFirebase(recipeProfile: recipeProfile)
        
        //showAlertMessage(title: "Recipe Clipper", message: "aaa")
        self.performSegue(withIdentifier: "showAddedRecipe", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        
        switch segmentRecipe.selectedSegmentIndex {
        case 0:
            ingredientsContainerView.isHidden = false
            StepsContainerView.isHidden = true
        case 1:
            ingredientsContainerView.isHidden = true
            StepsContainerView.isHidden = false
        default:
            print("No extra segement")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        txtRecipeTitle.text = recipeProfile.recipeTitle
        txtRecipeDescription.text = recipeProfile.recipeDescription
        
        //let Vc = parentViewController as! AddRecipeViewController
        
//        let ingredientVC = childViewControllers.first as! AddIngredientsViewController
//        ingredientVC.updateTable(recipeProfile: self.recipeProfile)
//        let stepVC = childViewControllers.last as! AddStepsViewController
//        stepVC.updateTable(recipeProfile: self.recipeProfile)
//        let stepVC = childViewControllers.last as! AddStepsViewController
//        stepVC.stepsArray = ingredientsArray
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        print(destination)
        
        if let IngredientController = destination as? AddIngredientsViewController {
            //locationTableViewController = locationController
            IngredientController.updateTable(recipeProfile: self.recipeProfile)
        }
        if let StepController = destination as? AddStepsViewController {
            //locationTableViewController = locationController
            StepController.updateTable(recipeProfile: self.recipeProfile)
        }
        if let ShowController = destination as? ShowRecipeDetailsViewController {
            //locationTableViewController = locationController
            ShowController.recipeProfile = self.recipeProfile
            ShowController.recipeID = self.recipeID
            
            print(recipeID ?? "No RecipeID in Add")
        }
    }
    
}

