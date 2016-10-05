//
//  AddHaunterViewController.swift
//  HalloweenHunt
//
//  Created by Diane Hoffstetter on 10/4/16.
//  Copyright © 2016 Dumb Blonde Software. All rights reserved.
//

import UIKit

class AddHaunterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

  @IBOutlet weak var haunterNameTextField: UITextField!
  @IBOutlet weak var latitudeSlider: UISlider!
  @IBOutlet weak var latitudeLabel: UILabel!
  @IBOutlet weak var longitudeSlider: UISlider!
  @IBOutlet weak var longitudeLabel: UILabel!
  @IBOutlet weak var isVisibleSwitch: UISwitch!
  @IBOutlet weak var ownerPicker: UIPickerView!
  
  var players: [Player] = []
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      ownerPicker.dataSource = self
      ownerPicker.delegate = self
      
      let player1 = Player()
      player1.email = "diane@dbx.com"
      player1.userName = "Diane"
      player1.isMaster = true
      players.append(player1)
      
      let player2 = Player()
      player2.email = "dave@dbx.com"
      player2.userName = "Dave"
      player2.isMaster = true
      players.append(player2)
      
      let player3 = Player()
      player3.email = "amanda@dbx.com"
      player3.userName = "Amanda"
      player3.isMaster = false
      players.append(player3)

      let latNom = 37.2281
      let latN = latNom + 0.5
      let latS = latNom - 0.5
      let longNom = -121.9085
      let longW = longNom - 0.5
      let longE = longNom + 0.5
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func addHaunterButtonPressed(_ sender: AnyObject) {
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


}
