//
//  Users.swift
//  Babysitter
//
//  Created by MARIA NATIVIDAD LARA DIAZ on 03/11/15.
//  Copyright © 2015 Appstract Development. All rights reserved.
//
import MapKit

class Users: NSObject {
    
    // MARK: - Public API
    
    var users = [User]()
    
    static func parse(nameFile: String) -> [User] {
        let users = Users(nameJsonFile: nameFile)
        users.parse()
        return users.users
    }
    
    
    // MARK: - Public Classes
    
    class User: NSObject {
        let name: String
        let password: String
        let email: String
        let aboutme: String
        let rating: String
        let longitude: String
        let latitude: String
        let imageURL: String
        
        init(name: String, password: String, email: String, aboutme: String, rating:String, longitude:String, latitude:String, imageURL:String) {
            self.name = name
            self.password = password
            self.email = email
            self.aboutme = aboutme
            self.rating = rating
            self.longitude = longitude
            self.latitude = latitude
            self.imageURL = imageURL
        }
        
    }
    
    // MARK: - Implementation
    private let nameFile: String
    
    private init(nameJsonFile: String) {
        self.nameFile = nameJsonFile
    }
    
    private func parse(){
        //Read JSON
        if let path = NSBundle.mainBundle().pathForResource(nameFile, ofType: "json"){
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
                            latitude: user["latitude"].string!,
                            imageURL:user["image"].string!)
                        users.append(babysitter)
                    }
                }else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        else {
            print("Invalid filename/path.")
        }
    }
    
    
}


