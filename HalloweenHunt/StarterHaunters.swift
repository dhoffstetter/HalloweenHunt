//
//  StarterHaunters.swift
//  HalloweenHunt
//
//  Created by Diane Hoffstetter on 10/6/16.
//  Copyright © 2016 Dumb Blonde Software. All rights reserved.
//

import Foundation

class StarterHaunters {
  
  var starters : [Haunter] = []
  
  init() {
    
    let haunter01 = Haunter()
    haunter01.name = "Ghost"
    haunter01.latitude = 37.2281
    haunter01.longitude = -121.9085
    haunter01.owner = "Master"
    haunter01.isFound = false
    haunter01.isVisible = true
    starters.append(haunter01)
    
    let haunter02 = Haunter()
    haunter02.name = "Bat"
    haunter02.latitude = 37.2291
    haunter02.longitude = -121.9095
    haunter02.owner = "Master"
    haunter02.isFound = false
    haunter02.isVisible = true
    starters.append(haunter02)

    let haunter03 = Haunter()
    haunter03.name = "Vampire"
    haunter03.latitude = 37.2301
    haunter03.longitude = -121.9105
    haunter03.owner = "Master"
    haunter03.isFound = false
    haunter03.isVisible = true
    starters.append(haunter03)


  }
  
  
}
