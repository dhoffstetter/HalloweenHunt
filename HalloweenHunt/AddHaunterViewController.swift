//
//  AddHaunterViewController.swift
//  HalloweenHunt
//
//  Created by Diane Hoffstetter on 10/4/16.
//  Copyright © 2016 Dumb Blonde Software. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class AddHaunterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

  @IBOutlet weak var haunterNameTextField: UITextField!
  @IBOutlet weak var latitudeSlider: UISlider!
  @IBOutlet weak var latitudeLabel: UILabel!
  @IBOutlet weak var longitudeSlider: UISlider!
  @IBOutlet weak var longitudeLabel: UILabel!
  @IBOutlet weak var isVisibleSwitch: UISwitch!
  @IBOutlet weak var isFoundSwitch: UISwitch!
  @IBOutlet weak var ownerPicker: UIPickerView!
  
  var players: [Player] = []
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      ownerPicker.dataSource = self
      ownerPicker.delegate = self
      haunterNameTextField.delegate = self
      
      FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: {(snapshot) in
        
        print(snapshot)
        
        let player = Player()
        player.userName = (snapshot.value! as AnyObject)["username"] as! String
        player.key = snapshot.key
        
        self.players.append(player)
        self.ownerPicker.reloadAllComponents()
      })

      /*
      let player1 = Player()
      player1.email = "diane@dbs.com"
      player1.userName = "Diane"
      player1.isMaster = true
      players.append(player1)
      
      let player2 = Player()
      player2.email = "dave@dbs.com"
      player2.userName = "Dave"
      player2.isMaster = true
      players.append(player2)
      
      let player3 = Player()
      player3.email = "amanda@dbs.com"
      player3.userName = "Amanda"
      player3.isMaster = false
      players.append(player3)
      */

      let latNom = 37.2281
      let latN = latNom + 0.5
      let latS = latNom - 0.5
      let longNom = -121.9085
      let longW = longNom - 0.5
      let longE = longNom + 0.5
      
      latitudeSlider.minimumValue = Float(latS)
      latitudeSlider.maximumValue = Float(latN)
      latitudeSlider.value = Float(latNom)
      latitudeLabel.text = String(latNom)
      longitudeSlider.minimumValue = Float(longW)
      longitudeSlider.maximumValue = Float(longE)
      longitudeSlider.value = Float(longNom)
      longitudeLabel.text = String(longNom)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func addHaunterButtonPressed(_ sender: AnyObject) {
    
    if haunterNameTextField.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) != "" {
      
      let row = ownerPicker.selectedRow(inComponent: 0)
      let owner = players[row].userName
      let haunter = ["name":haunterNameTextField.text!,"latitude":latitudeSlider.value,"longitude":longitudeSlider.value,"isVisible":isVisibleSwitch.isOn,"isFound":isFoundSwitch.isOn,"owner":owner] as [String : Any]
      
      FIRDatabase.database().reference().child("haunters").childByAutoId().setValue(haunter)
      
      self.navigationController!.popToRootViewController(animated: true)
    }
    else {
      
      let alert = UIAlertController(title: "Yo!", message: "Give the Ghoul a Name!", preferredStyle: UIAlertControllerStyle.alert)
      alert.addAction(UIAlertAction(title: "Duh!", style: UIAlertActionStyle.default, handler: nil))
      self.present(alert, animated : true, completion: nil)
    }
    
  }
  
  // UIPicker
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return players.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return players[row].userName
  }
  
  // UISlider
  
  @IBAction func latSliderChanged(_ sender: AnyObject) {
    
    latitudeLabel.text = String(latitudeSlider.value)
  }

  @IBAction func longSliderChanged(_ sender: AnyObject) {
    
    longitudeLabel.text = String(longitudeSlider.value)
  }
  
  // UITextField
  
  // Called when 'return' key pressed. return NO to ignore.
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  // Called when the user click on the view (outside the UITextField).
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }


}
