//
//  SignUpViewController.swift
//  ExamIOS9DEC
//
//  Created by Training1 on 12/9/18.
//  Copyright © 2018 ITA. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    var ref: DatabaseReference!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    
    fileprivate func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let user = UserClass()
        if let email = txtEmail.text {
            user.email = email
        }
        else {
            showAlert(title: "Error", message: "Please enter your email address")
        }
        if txtPassword.text == nil {
            showAlert(title: "Error", message: "Please enter your password")
        }
        if txtPassword.text != txtConfirmPass.text {
            showAlert(title: "Error", message: "Please re-type your password")
        }
        saveToFirebase(userClass: user)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        
    }
    fileprivate func registerUserToFirebase(_ user: UserClass) {
        if let userID = Auth.auth().currentUser?.uid {
            //let usersRef = ref.child("users")
            
            let dict = ["email": user.email ]
                        
            let thisUserRef = self.ref.child("users")
            thisUserRef.child(userID).setValue(dict)
                        
            self.showAlert(title: "Success", message: "Singup Succeeded")
            self.performSegue(withIdentifier: "SignUpSucceeded", sender: self)
                        
            print("Success")
        } else {
            print("No User")
        }
    }
    
    func saveToFirebase(userClass: UserClass) {
        
        if isValidEmail(testStr: txtEmail.text!){
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!){ (user, error) in
                if error == nil {
                    self.registerUserToFirebase(userClass)
                    }
                else{
                    self.showAlert(title: "Error", message: (error?.localizedDescription)!)
                }
            }
        }
        else{
            self.showAlert(title: "Error", message: "Invalid Email Address")
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

}
