//
//  Users.swift
//  Babysitter
//
//  Created by MARIA NATIVIDAD LARA DIAZ on 03/11/15.
//  Copyright © 2015 Appstract Development. All rights reserved.
//
import MapKit

class User: NSObject, MKAnnotation {
        let name: String
        let password: String
        let email: String
        let aboutme: String
        let rating: String
        let coordinate: CLLocationCoordinate2D
        let title: String?
        let subtitle: String?
        
        init(name: String, password: String, email: String, aboutme: String, rating:String, longitude:String, latitude:String) {
            self.name = name
            self.password = password
            self.email = email
            self.aboutme = aboutme
            self.rating = rating
            self.coordinate = CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
            self.title = name
            self.subtitle = email
            
            super.init()
        }

}

