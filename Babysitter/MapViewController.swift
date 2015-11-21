//
//  MapViewController.swift
//  Babysitter
//
//  Created by MARIA NATIVIDAD LARA DIAZ on 21/10/15.
//  Copyright © 2015 Appstract Development. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    // MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    // MARK: - Public API
    var nameJsonFile: String? {
        didSet {
            clearMarkers()
            let users = Users.parse(nameJsonFile!)
            handleMarkers(users)
        }
    }
    
    // MARK: - Constants
    private struct Constants {
        static let AnnotationViewReuseIdentifier = "user"
        static let LeftCalloutFrame = CGRect(x: 0, y: 0, width: 59, height: 59)
    }
    
    
    // MARK: - Markers
    
    private func clearMarkers(){
        if mapView?.annotations != nil {
            mapView.removeAnnotations(mapView.annotations as [MKAnnotation])
        }
    }
    
    private func handleMarkers(users: [Users.User]){
        mapView.addAnnotations(users)
        mapView.showAnnotations(users, animated: true)
      
    }
    
    // MARK: MapViewDelegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if  mapView.userLocation == true { //this is so the pin of the current location don't show an annotation
            return nil
        } else{
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(Constants.AnnotationViewReuseIdentifier)
            
            if view == nil {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.AnnotationViewReuseIdentifier)
                view!.canShowCallout = true
                view!.image = UIImage(named: "pin.png")
            } else {
                view!.annotation = annotation
            }
            
            view?.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            
            
        return view
        }
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if mapView.userLocation == false {
            view.image = UIImage(named: "pin_active.png")
        }
    }
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        if mapView.userLocation == false {
            view.image = UIImage(named: "pin.png")
        } else {
            
        }
    }
    
    
    // MARK: - View Controller Lifecycle
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        
        //Give the name of the file
        nameJsonFile = "users"
        
    }
    
    
    // MARK: - Location Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
    }
    
}
