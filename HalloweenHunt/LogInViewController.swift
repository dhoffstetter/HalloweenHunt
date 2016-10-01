//
//  LogInViewController.swift
//  HalloweenHunt
//
//  Created by Diane Hoffstetter on 10/1/16.
//  Copyright © 2016 Dumb Blonde Software. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var userNameTextField: UITextField!
  
  // Temp input for development
  
  var email = "diane@dbs.com"
  var password = "password"
  var username = "Master"
  
  var isMaster = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    emailTextField.text = email
    passwordTextField.text = password
    userNameTextField.text = username
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func hauntingButtonPressed(_ sender: AnyObject) {
    
    // Master has option to go to managing game
    
    if !isNonWhiteSpaceString(str: emailTextField.text!) || !isNonWhiteSpaceString(str: passwordTextField.text!) || !isNonWhiteSpaceString(str: userNameTextField.text!) {
      
      let alert = UIAlertController(title: "Yo!", message: "No Blank Fields Allowed!", preferredStyle: UIAlertControllerStyle.alert)
      alert.addAction(UIAlertAction(title: "Oh, Okay!", style: UIAlertActionStyle.default, handler: nil))
      self.present(alert, animated : true, completion: nil)
    }
    else {
      
      if isMaster {
        
        let alert = UIAlertController(title: "Master!", message: "Do you want to master the game?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes!", style: UIAlertActionStyle.default, handler: {
          (action) -> Void in print("Yes!")
        }))
        alert.addAction(UIAlertAction(title: "Nope.", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated : true, completion: nil)

      }
      
    }
    
  }

  
  func isNonWhiteSpaceString(str : String) -> Bool  {
    if str.trimmingCharacters(in: NSCharacterSet.whitespaces) != "" {
      return true
    }
    return false

  }

}

