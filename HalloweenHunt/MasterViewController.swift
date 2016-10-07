//
//  MasterViewController.swift
//  HalloweenHunt
//
//  Created by Diane Hoffstetter on 10/1/16.
//  Copyright © 2016 Dumb Blonde Software. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var haunterTableView: UITableView!
  
  var haunters : [Haunter] = []
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      haunterTableView.delegate = self
      haunterTableView.dataSource = self

      FIRDatabase.database().reference().child("haunters").observe(FIRDataEventType.childAdded, with: {(snapshot) in
        
        print(snapshot)
        
        let haunter = Haunter()
        haunter.name = (snapshot.value! as AnyObject)["name"] as! String
        haunter.key = snapshot.key

        
        self.haunters.append(haunter)
        self.haunterTableView.reloadData()
      })
      
      FIRDatabase.database().reference().child("haunters").observe(FIRDataEventType.childRemoved, with: {(snapshot) in
        
        print(snapshot)
        
        self.haunterTableView.reloadData()
        
      })


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func reloadButtonPressed(_ sender: AnyObject) {
    
    let alert = UIAlertController(title: "Reload???", message: "Do you really want to reload Starters?", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Yes!", style: UIAlertActionStyle.default, handler: {
      (action) -> Void in
      
      let starterHaunters = StarterHaunters()
      
      for starter in starterHaunters.starters {
        
        let haunter = ["name":starter.name,"latitude":starter.longitude,"longitude":starter.longitude,"isVisible":starter.isVisible,"isFound":starter.isFound,"owner":starter.owner] as [String : Any]
        
        FIRDatabase.database().reference().child("haunters").childByAutoId().setValue(haunter)
      }
      
    }))
    alert.addAction(UIAlertAction(title: "Nope.", style: UIAlertActionStyle.default, handler: {
      (action) -> Void in
      
    }))
    self.present(alert, animated : true, completion: nil)
    
  }
  
  @IBAction func wipeoutButtonPressed(_ sender: AnyObject) {
    
    let alert = UIAlertController(title: "Wipeout???", message: "Do you really want to wipe out the Haunters?", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Yes!", style: UIAlertActionStyle.default, handler: {
      (action) -> Void in
      
      for losers in self.haunters {
        
        FIRDatabase.database().reference().child("haunters").child(losers.key).removeValue()
      }
      
      self.haunters.removeAll()
      
    }))
    alert.addAction(UIAlertAction(title: "Nope.", style: UIAlertActionStyle.default, handler: {
      (action) -> Void in
      
    }))
    self.present(alert, animated : true, completion: nil)

  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return haunters.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "HaunterCell")
    
    cell.textLabel?.text = haunters[indexPath.row].name
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
  

}
