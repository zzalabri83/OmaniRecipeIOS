//
//  ViewController.swift
//  OmaniRecipeV1.1
//
//  Created by Training1 on 12/16/18.
//  Copyright © 2018 ITA. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnSignIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "SignInSucceeded", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            //self.performSegue(withIdentifier: "SignInSucceeded", sender: nil)
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
        let image = UIImage(named: "apple2")
        imageView.alpha = 0.5
        
        imageView.image = image
        txtEmail.leftViewMode = .always
        txtEmail.leftView = imageView
        //txtEmail.addSubview(imageView)
        
        //txtEmail.rightViewMode = .always
        //txtEmail.rightView = imageView
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


