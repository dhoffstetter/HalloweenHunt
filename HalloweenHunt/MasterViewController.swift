//
//  MasterViewController.swift
//  HalloweenHunt
//
//  Created by Diane Hoffstetter on 10/1/16.
//  Copyright © 2016 Dumb Blonde Software. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var haunterTableView: UITableView!
  
  var haunters : [Haunter] = []
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      haunterTableView.delegate = self
      haunterTableView.dataSource = self
      
      let haunter1 = Haunter()
      haunter1.name = "bob"
      haunters.append(haunter1)
      let haunter2 = Haunter()
      haunter2.name = "betty"
      haunters.append(haunter2)
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
