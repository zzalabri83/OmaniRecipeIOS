//
//  MenuBarViewController.swift
//  OmaniRecipeV1.1
//
//  Created by Training1 on 12/18/18.
//  Copyright © 2018 ITA. All rights reserved.
//

import UIKit

class MenuBarViewController: UIViewController {

    @IBAction func btnGoHome(_ sender: Any) {
        self.performSegue(withIdentifier: "gohome", sender: nil)
    }
    
    @IBAction func btnGoNextScreen(_ sender: Any) {
        //self.performSegue(withIdentifier: "gonext", sender: nil)
        //self.dismiss(animated: true, completion: {})
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
