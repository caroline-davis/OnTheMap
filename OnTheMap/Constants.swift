//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Caroline Davis on 28/09/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation

extension Client {
    
    // array from students info
    //var students = [StudentInfo]()
    
    
    struct URLs {
        static let AuthorizationURL: String = "https://www.udacity.com/api"
    }
    
    struct Methods {
        static let Session = "/session"
        
    }
    
    // getting parameter keys
    struct StudentInfoKeys {
        static let createdAt = "createdAt"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let mapString = "mapString"
        static let mediaURL = "mediaURL"
        static let objectId = "objectId"
        static let uniqueKey = "uniqueKey"
        static let updatedAt = "updatedAt"
    }
    
    // using parameter keys
    struct StudentInfo {
        let createdAt: String
        let firstName: String
        let lastName: String
        let longitude: Double
        let latitude: Double
        let mapString: String
        let mediaURL: String
        let objectId: String
        let uniqueKey: Int
        let updatedAt: String
        
        init(createdAt: String, firstName: String, lastName: String, longitude: Double, latitude: Double, mapString: String, mediaURL: String, objectId: String, uniqueKey: Int, updatedAt: String) {
            
            self.createdAt = createdAt
            self.firstName = firstName
            self.lastName = lastName
            self.longitude = longitude
            self.latitude = latitude
            self.mapString = mapString
            self.mediaURL = mediaURL
            self.objectId = objectId
            self.uniqueKey = uniqueKey
            self.updatedAt = updatedAt
        }
    }
}