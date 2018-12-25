//
//  HomeViewController.swift
//  AKSideMenuSimple
//
//  Created by Diogo Autilio on 6/6/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import UIKit

public class HomeViewController: UIViewController {

    @IBAction func btnGoNext(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segueRecipeDetails", sender: nil)
        
    }
    @IBAction func btnAddRecipe(_ sender: Any) {
        self.performSegue(withIdentifier: "addRecipe", sender: nil)
    }
    @IBAction func btnRecipeClipper(_ sender: Any) {
        self.performSegue(withIdentifier: "recipeClipper", sender: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeViewController will appear")
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("HomeViewController will disappear")
    }
}
