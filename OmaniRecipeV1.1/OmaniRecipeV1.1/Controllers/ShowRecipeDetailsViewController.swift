//
//  ShowRecipeDetailsViewController.swift
//  OmaniRecipeV1.1
//
//  Created by Zahran on 12/25/18.
//  Copyright © 2018 ITA. All rights reserved.
//

import UIKit

class ShowRecipeDetailsViewController: UIViewController {

    var recipeProfile = RecipeProfile()
    var recipeID: String?
    
    fileprivate var viewModel = ProfileViewModel()
    //var viewModel = ProfileViewModel.self
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func btnDone(_ sender: Any) {
        tableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(recipeProfile.recipeTitle)
        
        //if let recipe = self.recipeProfile {
            let viewM = ProfileViewModel(recipeProfile: recipeProfile)
        viewModel = viewM
        
            tableView.dataSource = viewModel
            
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableViewAutomaticDimension
            
            tableView.register(AboutCell.nib, forCellReuseIdentifier: AboutCell.identifier)
            tableView?.register(NamePictureCell.nib, forCellReuseIdentifier: NamePictureCell.identifier)
            tableView?.register(IngredientCell.nib, forCellReuseIdentifier: IngredientCell.identifier)
            tableView?.register(StepCell.nib, forCellReuseIdentifier: StepCell.identifier)
        //}
    }

}
