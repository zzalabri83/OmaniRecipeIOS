//
//  ViewController.swift
//  Downloading Web Content
//
//  Created by Rob Percival on 20/06/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import WebKit

class RecipeClipperViewController: UIViewController, UIWebViewDelegate {

    var task = URLSessionDataTask()
    
    var titleDone = false
    var descriptionDone = false
    var ingredientsDone = false
    var stepsDone = false
    
    var recipeProfile = RecipeProfile()
    var ingredientsArray = [String]()
    var stepsArray = [String]()
    
    @IBOutlet var webview: UIWebView!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        task.cancel()
        webview.stopLoading()
        self.performSegue(withIdentifier: "updateClipper", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AddRecipeViewController
        destinationVC.recipeProfile = recipeProfile
    }
    
    func checkToEnableButtonDone() {
        if titleDone && descriptionDone && ingredientsDone && stepsDone {
            btnDone.isEnabled = true
            print("Done")
        }
    }
    
    func getRecipeTitle(_ dataString: NSString?) {
        var stringSeparator = "<h1 id=\"recipe-main-content\" class=\"recipe-summary__h1\" itemprop=\"name\">"
        
        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
            print("==========================================")
            if contentArray.count > 1 {
                for item in contentArray {
                    stringSeparator = "</h1>"
                    if item == contentArray[0]{
                        print("Skip first item")
                    }else {
                        let newContentArray = item.components(separatedBy: stringSeparator)
                        if newContentArray.count > 1 {
                            let message = newContentArray[0]
                            print(message)
                            recipeProfile.recipeTitle = newContentArray[0]
                            titleDone = true
                            checkToEnableButtonDone()
                        }
                    }
                }
            }
        }
    }
    func getRecipeDescription(_ dataString: NSString?) {
        var stringSeparator = "<div class=\"submitter__description\" itemprop=\"description\">"
        
        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
            print("==========================================")
            if contentArray.count > 1 {
                for item in contentArray {
                    stringSeparator = "</div>"
                    if item == contentArray[0]{
                        print("Skip first item")
                    }else {
                        let newContentArray = item.components(separatedBy: stringSeparator)
                        if newContentArray.count > 1 {
                            let message = newContentArray[0]
                            print(message)
                            recipeProfile.recipeDescription = newContentArray[0]
                            descriptionDone = true
                            checkToEnableButtonDone()
                        }
                    }
                }
            }
        }
    }
    func getIngredients(_ dataString: NSString?) {
        var stringSeparator = "itemprop=\"recipeIngredient\">"
        
        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
            print("==========================================")
            if contentArray.count > 1 {
                for item in contentArray {
                    stringSeparator = "</span>"
                    if item == contentArray[0]{
                        print("Skip first item")
                    }else {
                        let newContentArray = item.components(separatedBy: stringSeparator)
                        if newContentArray.count > 1 {
                            let ingredient = Ingredient(dict: ["nameE": newContentArray[0], "amount": ""])
                            recipeProfile.ingredients.append(ingredient)
                            ingredientsDone = true
                            checkToEnableButtonDone()
                        }
                    }
                }
            }
        }
    }
    func getSteps(_ dataString: NSString?) {
        var stringSeparator = "<span class=\"recipe-directions__list--item\">"
        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
            print("==========================================")
            if contentArray.count > 1 {
                for item in contentArray {
                    stringSeparator = "</span>"
                    if item == contentArray[0]{
                        print("Skip first item")
                    }else {
                        let newContentArray = item.components(separatedBy: stringSeparator)
                        if newContentArray.count > 1 {
                            let step = Step(dict: ["nameE": newContentArray[0], "imageURL": ""])
                            recipeProfile.steps.append(step)
                            stepsDone = true
                            checkToEnableButtonDone()
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        webview.delegate = self
        btnDone.isEnabled = false
        
        if let url = URL(string: "https://www.allrecipes.com/recipe/234621/rusty-chicken-thighs/") {
        
            let request = NSMutableURLRequest(url: url)
            
            
            task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    print(error!)
                } else {
                    if let unwrappedData = data {
                        DispatchQueue.main.async(execute: {
                            // Update UI
                            self.webview.loadRequest(request as URLRequest)
                        })
                        DispatchQueue.main.async(execute: {
                            let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                            
                            self.getIngredients(dataString)
                            self.getSteps(dataString)
                            self.getRecipeTitle(dataString)
                            self.getRecipeDescription(dataString)
                        })
                        
                    }
                }
                
                
            }
            
            task.resume()
            
        }
        
        print("Hi there!")
        
        print(recipeProfile)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

