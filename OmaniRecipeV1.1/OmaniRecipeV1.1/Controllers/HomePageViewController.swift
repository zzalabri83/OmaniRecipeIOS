//
//  HomePageViewController.swift
//  OmaniRecipeV1.1
//
//  Created by Training1 on 12/18/18.
//  Copyright © 2018 ITA. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBAction func btngonemu(_ sender: Any) {
        self.performSegue(withIdentifier: "gomenu", sender: nil)
    }
    
    @IBAction func btnGoDetails(_ sender: Any) {
        self.performSegue(withIdentifier: "godetails", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
