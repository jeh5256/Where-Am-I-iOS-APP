//
//  ViewController.swift
//  Where Am I
//
//  Created by Justin Hughes on 12/13/15.
//  Copyright © 2015 Justin Hughes. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!
    
    //creat IBOutlets for labels

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var alititudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.'
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        let userLocation:CLLocation = locations[0]
        
        
        self.latitudeLabel.text = "\(round(userLocation.coordinate.latitude))"
        self.longitudeLabel.text = "\(round(userLocation.coordinate.longitude))"
        
        self.courseLabel.text = "\(round(userLocation.course))"
        self.speedLabel.text = "\(round(userLocation.speed))"
        self.alititudeLabel.text = "\(round(userLocation.altitude))"
        
        //takes a location and converts it to an address
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            
            
            //check for an error
            
            if (error != nil){
                
                print(error)
            }
            
            else{
                
                if let p = placemarks?.first{
                    
                    var subThoroughfare:String = ""
                    var subLocality = ""
                
                    if (p.subThoroughfare != nil){
                        
                        subThoroughfare = p.subThoroughfare!
                        
                    }
                    
                    if(p.subLocality != nil){
                        
                        subLocality = p.subLocality!
                        self.addressLabel.text = "\(subThoroughfare) \(p.thoroughfare!) \n \(p.subLocality) \n \(p.subAdministrativeArea!) \n \(p.postalCode!) \n \(p.country!)"
                    }
                    
                    else {
                        self.addressLabel.text = "\(subThoroughfare) \(p.thoroughfare!) \n \(p.subAdministrativeArea!) \n \(p.postalCode!) \n \(p.country!)"
                    
                    }
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

