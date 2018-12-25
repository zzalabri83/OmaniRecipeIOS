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

class OldAddRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    var ref = DatabaseReference()
    var recipeProfile = RecipeProfile()
    
    var ingredientsArray = [String]()
    var stepsArray = [String]()
    var tableCount1 = 3
    var tableCount2 = 3
    var cellHeightTable1 = 48
    var cellHeightTable2 = 60
    
    @IBOutlet weak var imgRecipe: UIImageView!
    @IBOutlet weak var txtRecipeTitle: UITextField!
    @IBOutlet weak var txtRecipeDescription: UITextField!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var tableViewHeightLayoutTable1: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightLayoutTable2: NSLayoutConstraint!
    
    fileprivate func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        //alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func btnSaveRecipe(_ sender: Any) {
    
        saveIngredientsArray()
        saveStepsArray()
        
        let recipeProfile = RecipeProfile()
        
        for item in ingredientsArray {
            let ingredients = Ingredient()
            ingredients.nameE = item
            recipeProfile.ingredients.append(ingredients)
        }
        for item in stepsArray {
            let steps = Step()
            steps.nameE = item
            recipeProfile.steps.append(steps)
        }
        if let title = txtRecipeTitle.text {
            recipeProfile.recipeTitle = title
        }
        if let description = txtRecipeDescription.text {
            recipeProfile.recipeDescription = description
        }
        recipeProfile.imageURL = "Here is an image"
        
        recipeProfile.saveRecipeToFirebase(recipeProfile: recipeProfile)
        
        showAlertMessage(title: "Recipe Clipper", message: "aaa")
        self.performSegue(withIdentifier: "showAddedRecipe", sender: nil)
        
    }
    
    @IBAction func btnAddIngredient(_ sender: Any) {
        saveIngredientsArray()
        
        let indexPathCount = tableView1.numberOfRows(inSection: 0)
        //Add one more row if only all field are filled
        if (indexPathCount - ingredientsArray.count) < 1 {
            tableCount1 += 1
            tableViewHeightLayoutTable1.constant = CGFloat( tableCount1 * cellHeightTable1 + cellHeightTable1 - 15 )
            tableView1.reloadData()
        }
    }
    
    @IBAction func btnAddStep(_ sender: Any) {
        saveStepsArray()
        
        let indexPathCount = tableView2.numberOfRows(inSection: 0)
        //Add one more row if only all field are filled
        if (indexPathCount - stepsArray.count) < 1 {
            tableCount2 += 1
            tableViewHeightLayoutTable2.constant = CGFloat( tableCount2 * cellHeightTable2 + cellHeightTable2 )
            tableView2.reloadData()
            tableView2.scrollToRow(at: IndexPath(row: indexPathCount, section: 0), at: UITableViewScrollPosition.none, animated: true)
        }
    }
    
    fileprivate func saveIngredientsArray() {
        let indexPathCount = tableView1.numberOfRows(inSection: 0)
        ingredientsArray.removeAll()
        var i = 0
        while i <= indexPathCount {
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = tableView1.cellForRow(at: indexPath) as? AddIngredientTableViewCell  {
                if let text = cell.txtCell1.text {
                    if text != "" {
                        ingredientsArray.append( text )
                    }
                }
            }
            i += 1
        }
    }
    fileprivate func saveStepsArray() {
        let indexPathCount = tableView2.numberOfRows(inSection: 0)
        stepsArray.removeAll()
        var i = 0
        while i <= indexPathCount {
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = tableView2.cellForRow(at: indexPath) as? AddStepTableViewCell  {
                if let text = cell.txtCell2.text {
                    if text != "" {
                        stepsArray.append( text )
                    }
                }
            }
            i += 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView1 {
            return tableCount1
        }else if tableView == self.tableView2 {
            return tableCount2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView1 {
            let cell = self.tableView1.dequeueReusableCell(withIdentifier: "Cell1") as! AddIngredientTableViewCell
            if indexPath.row < ingredientsArray.count {
                cell.configure(text: ingredientsArray[indexPath.row], placeholder: "Enter some text!")
            }else{
                cell.configure(text: "", placeholder: "Enter some text!")
            }
            cell.txtCell1.delegate = self
            return cell
        }else if tableView == self.tableView2 {
            let cell = self.tableView2.dequeueReusableCell(withIdentifier: "Cell2") as! AddStepTableViewCell
            if indexPath.row < stepsArray.count {
                cell.configure(text: stepsArray[indexPath.row], placeholder: "Enter some text!")
            }else{
                cell.configure(text: "", placeholder: "Enter some text!")
            }
            cell.txtCell2.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.tableView1 {
            return "Ingredients"
        }else if tableView == self.tableView2 {
            return "Steps"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView1 {
            return CGFloat(cellHeightTable1)
        }else if tableView == self.tableView2 {
            return CGFloat(cellHeightTable2)
        }
        return 50.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView2.delegate = self
        tableView2.dataSource = self
        
        //tableView1.backgroundColor = UIColor.clear
        tableView2.backgroundColor = UIColor.clear
        
        //tableViewHeightLayoutTable1.constant = CGFloat( tableCount1 * cellHeightTable1 + cellHeightTable1 - 15 )
        //tableViewHeightLayoutTable2.constant = CGFloat( tableCount2 * cellHeightTable2 + cellHeightTable2 - 15 )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(recipeProfile.recipeTitle)
        
        txtRecipeTitle.text = recipeProfile.recipeTitle
        txtRecipeDescription.text = recipeProfile.recipeDescription
        
        ingredientsArray.removeAll()
        stepsArray.removeAll()
        
        for item in recipeProfile.ingredients {
            print(item.nameE)
            ingredientsArray.append(item.nameE)
        }
        for item in recipeProfile.steps {
            print(item.nameE)
            stepsArray.append(item.nameE)
        }
        tableCount1 = ingredientsArray.count
        tableViewHeightLayoutTable1.constant = CGFloat( tableCount1 * cellHeightTable1 + cellHeightTable1 - 15 )
        tableCount2 = stepsArray.count
        tableViewHeightLayoutTable2.constant = CGFloat( tableCount2 * cellHeightTable2 + cellHeightTable2 - 15 )
        tableView1.reloadData()
        tableView2.reloadData()
        
        print(ingredientsArray)
        print(stepsArray)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

