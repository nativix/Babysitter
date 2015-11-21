//
//  MKUsers.swift
//  Babysitter
//
//  Created by MARIA NATIVIDAD LARA DIAZ on 10/11/15.
//  Copyright © 2015 Appstract Development. All rights reserved.
//

import MapKit

extension Users.User: MKAnnotation
{
    var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
    }
    
    var title: String? {
        return name
    }
    var subtitle: String? {
        return email
    }
    
}
