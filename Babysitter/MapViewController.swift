//
//  MapViewController.swift
//  Babysitter
//
//  Created by MARIA NATIVIDAD LARA DIAZ on 21/10/15.
//  Copyright © 2015 Appstract Development. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial location to the map
        let initialLocation = CLLocation(latitude: 55.6541075, longitude: 12.5910091)
        centerMapOnLocation(initialLocation)
        
        //Dar el nombre de un Json file y que me regrese una lista de users.
        var users = [User]()
        
        
        //Read JSON
        if let path = NSBundle.mainBundle().pathForResource("users", ofType: "json"){
            do{
                let data = try NSData(contentsOfURL: NSURL (fileURLWithPath: path), options:NSDataReadingOptions.DataReadingMappedIfSafe)
                let usersJSON = JSON(data:data)
                if usersJSON != JSON.null{
                    //loop in the users and create a User object and add it to the map
                    for (_,user):(String,JSON) in usersJSON {
                        let babysitter = User(name: user["name"].string!,
                            password: user["password"].string!,
                            email: user["email"].string!,
                            aboutme: user["aboutme"].string!,
                            rating: user["rating"].string!,
                            longitude: user["longitude"].string!,
                            latitude: user["latitude"].string!)
                        mapView.addAnnotation(babysitter)
                    }
                }else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }

        
    }
    
    // zoom and stuff
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
}
