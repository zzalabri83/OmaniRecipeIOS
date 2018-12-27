//
//  AddStepsViewController.swift
//  OmaniRecipeV1.1
//
//  Created by Zahran on 12/25/18.
//  Copyright © 2018 ITA. All rights reserved.
//

import UIKit

class AddStepsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var recipeProfile = RecipeProfile()
    var stepsArray = [String]()
    var tableCount = 3
    var cellHeightTable2 = 60
    
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var tableViewHeightLayoutTable2: NSLayoutConstraint!
    
    @IBAction func btnAddStep(_ sender: Any) {
        saveStepsArray()
        
        let indexPathCount = tableView2.numberOfRows(inSection: 0)
        //Add one more row if only all field are filled
        if (indexPathCount - stepsArray.count) < 1 {
            tableCount += 1
            tableViewHeightLayoutTable2.constant = CGFloat( tableCount * cellHeightTable2 + cellHeightTable2 )
            tableView2.reloadData()
            tableView2.scrollToRow(at: IndexPath(row: indexPathCount, section: 0), at: UITableViewScrollPosition.none, animated: true)
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
        return tableCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView2.dequeueReusableCell(withIdentifier: "Cell2") as! AddStepTableViewCell
        if indexPath.row < stepsArray.count {
            cell.configure(text: stepsArray[indexPath.row], placeholder: "Enter some text!")
        }else{
            cell.configure(text: "", placeholder: "Enter some text!")
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(cellHeightTable2)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tableView2.delegate = self
        tableView2.dataSource = self
        
        
        tableView2.estimatedRowHeight = 44.0
        tableView2.rowHeight = UITableViewAutomaticDimension
        
        //tableView2.backgroundColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    public func updateTable(recipeProfile: RecipeProfile){
        stepsArray.removeAll()
        self.recipeProfile = recipeProfile
        for item in recipeProfile.steps {
            if let nameE = item.nameE {
                stepsArray.append(nameE)
            }
        }
        
        tableCount = stepsArray.count
        //tableViewHeightLayoutTable2.constant = CGFloat( tableCount * cellHeightTable2 + cellHeightTable2 - 15 )
        
        //tableView2.reloadData()
    }
}
