//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Caroline Davis on 28/09/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import MapKit

extension Client {
    
    // constant URLs
    struct URLs {
        static let authorizationURL = "https://www.udacity.com/api"
        static let parseURL = "https://parse.udacity.com/parse/classes/StudentLocation"
    }
    
    // api basic methods
    struct Methods {
        static let session = "/session"
    }
    
    struct StudentLocationParameters {
        static let limit = "?limit=100"
        static let skipAndLimit = "?limit=200&skip=400"
        static let descendingOrder = "&order=-updatedAt"
        static let whereStudentIs = "?where={uniqueKey:uniqueKey}"
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
        let createdAt: String?
        let firstName: String?
        let lastName: String?
        let longitude: Double?
        let latitude: Double?
        let mapString: String?
        let mediaURL: String?
        let objectId: String?
        let uniqueKey: String?
        let updatedAt: String?
        
        init(studentDictionary: Dictionary<String, AnyObject>) {
            
            self.createdAt = studentDictionary["createdAt"] as? String
            self.firstName = studentDictionary["firstName"] as? String
            self.lastName = studentDictionary["lastName"] as? String
            self.longitude = studentDictionary["longitude"] as? Double
            self.latitude = studentDictionary["latitude"] as? Double
            self.mapString = studentDictionary["mapString"] as? String
            self.mediaURL = studentDictionary["mediaURL"] as? String
            self.objectId = studentDictionary["objectId"] as? String
            self.uniqueKey = studentDictionary["uniqueKey"] as? String
            self.updatedAt = studentDictionary["updatedAt"] as? String
        }
    }
    
}