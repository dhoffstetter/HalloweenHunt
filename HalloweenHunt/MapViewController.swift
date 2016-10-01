//
//  MapViewController.swift
//  HalloweenHunt
//
//  Created by Diane Hoffstetter on 10/1/16.
//  Copyright © 2016 Dumb Blonde Software. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
  
  @IBOutlet weak var mapView: MKMapView!
  
  var manager = CLLocationManager()
  var updateCount = 0
  let zoomDist = 300


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      manager.delegate = self
      
      if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
        mapView.showsUserLocation = true
        manager.startUpdatingLocation()
      }
      else {
        manager.requestWhenInUseAuthorization()        
      }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    if updateCount < 3 {
      
      let region = MKCoordinateRegionMakeWithDistance((manager.location?.coordinate)!, CLLocationDistance(zoomDist), CLLocationDistance(zoomDist))
      mapView.setRegion(region, animated: false)
      updateCount += 1
    }
    else {
      manager.stopUpdatingLocation()
    }
  }


}
