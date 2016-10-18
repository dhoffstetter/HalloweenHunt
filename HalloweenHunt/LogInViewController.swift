//
//  LogInViewController.swift
//  HalloweenHunt
//
//  Created by Diane Hoffstetter on 10/1/16.
//  Copyright © 2016 Dumb Blonde Software. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LogInViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var userNameTextField: UITextField!
  
  // Temp input for development
  
  var email = "diane@dbs.com"
  var password = "password"
  var username = "Master"
  
  var isMaster = false
  
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
      
      FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
        print("*************************************************We tried to sign in.")
        if error != nil {
          print("We have an error : \(error)")
          
          FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
            print("We tried to create a user")
            
            if error != nil {
              
              print("***************************************We have an error : \(error)")
              let alert = UIAlertController(title: "Drat!", message: "Zombies have taken over the network. Try again later", preferredStyle: UIAlertControllerStyle.alert)
              alert.addAction(UIAlertAction(title: "Bummer", style: UIAlertActionStyle.default, handler: nil))
              self.present(alert, animated : true, completion: nil)

            }
            else {
              
              print("Created User successfully!")
              
              FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email)
              FIRDatabase.database().reference().child("users").child(user!.uid).child("username").setValue(self.userNameTextField.text)
              
              self.letsMoveOn()
              
            }
          })
          
        }
        else {
          print("Signed in successfully!")
          
          if self.email == "diane@dbs.com" {
            self.isMaster = true
          }
          self.letsMoveOn()
        }
      })

    }
    
  }
  
  func letsMoveOn() -> Void {
    
    if isMaster {
      
      letTheMasterDecide()
    }
    else {
      
      self.performSegue(withIdentifier: "logInToMapSegue", sender: nil)
    }
    
  }

  func letTheMasterDecide() -> Void {
    
    if isMaster {
      
      let alert = UIAlertController(title: "Master!", message: "Do you want to master the game?", preferredStyle: UIAlertControllerStyle.alert)
      alert.addAction(UIAlertAction(title: "Yes!", style: UIAlertActionStyle.default, handler: {
        (action) -> Void in
        
        self.performSegue(withIdentifier: "logInToMasterSegue", sender: self)
        
      }))
      alert.addAction(UIAlertAction(title: "Nope.", style: UIAlertActionStyle.default, handler: {
        (action) -> Void in
        
        self.performSegue(withIdentifier: "logInToMapSegue", sender: self)
        
      }))
      self.present(alert, animated : true, completion: nil)
      
    }
  }
  
  func isNonWhiteSpaceString(str : String) -> Bool  {
    if str.trimmingCharacters(in: NSCharacterSet.whitespaces) != "" {
      return true
    }
    return false

  }

}


