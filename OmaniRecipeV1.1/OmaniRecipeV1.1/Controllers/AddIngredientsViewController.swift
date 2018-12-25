//
//  AddIngredientsViewController.swift
//  OmaniRecipeV1.1
//
//  Created by Zahran on 12/25/18.
//  Copyright © 2018 ITA. All rights reserved.
//

import UIKit

class AddIngredientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var recipeProfile = RecipeProfile()
    var ingredientsArray = [String]()
    var tableCount = 3
    var cellHeightTable1 = 48
    
    @IBOutlet weak var tableViewIngredient: UITableView!
    
    
    @IBOutlet weak var tableViewHeightLayoutTable1: NSLayoutConstraint!
    
    @IBAction func btnAddIngredient(_ sender: Any) {
        
        saveIngredientsArray()
        tableViewIngredient.reloadData()
        
        let indexPathCount = tableViewIngredient.numberOfRows(inSection: 0)
        //Add one more row if only all field are filled
        if (indexPathCount - ingredientsArray.count) < 1 {
            tableCount += 1
            tableViewHeightLayoutTable1.constant = CGFloat( tableCount * cellHeightTable1 + cellHeightTable1 - 15 )
            tableViewIngredient.reloadData()
        }
    }
    
    fileprivate func saveIngredientsArray() {
        let indexPathCount = tableViewIngredient.numberOfRows(inSection: 0)
        ingredientsArray.removeAll()
        var i = 0
        while i <= indexPathCount {
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = tableViewIngredient.cellForRow(at: indexPath) as? AddIngredientTableViewCell  {
                if let text = cell.txtCell1.text {
                    if text != "" {
                        ingredientsArray.append( text )
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
        return tableCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewIngredient.dequeueReusableCell(withIdentifier: "IngCell") as! AddIngredientTableViewCell
        if indexPath.row < ingredientsArray.count {
            cell.configure(text: ingredientsArray[indexPath.row], placeholder: "Enter some text!")
        }else{
            cell.configure(text: "", placeholder: "Enter some text!")
        }
        //cell.txtCell1.delegate = self
//        tableViewIngredient.rowHeight = tableViewIngredient.rowHeight + 50
//        print(tableViewIngredient.rowHeight)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(cellHeightTable1+20*indexPath.row)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tableViewIngredient.delegate = self
        tableViewIngredient.dataSource = self
        
        tableViewIngredient.estimatedRowHeight = 44.0
        tableViewIngredient.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableViewIngredient.reloadData()
    }
    
    public func updateTable(recipeProfile: RecipeProfile){
        ingredientsArray.removeAll()
        self.recipeProfile = recipeProfile
        for item in recipeProfile.ingredients {
            print(item.nameE)
            ingredientsArray.append(item.nameE)
        }
        
        tableCount = ingredientsArray.count
        //tableViewHeightLayoutTable1.constant = CGFloat( tableCount * cellHeightTable1 + cellHeightTable1 - 15 )
        
        //tableViewIngredient.reloadData()
    }
    
}
