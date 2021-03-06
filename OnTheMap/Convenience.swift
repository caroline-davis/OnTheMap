//
//  Convenience.swift
//  OnTheMap
//
//  Created by Caroline Davis on 29/09/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension Client {
    
    
    func postSessionID(sender: AnyObject, username: String, password: String, completionHandlerForAuth: (success: Bool, errorString: String?) -> Void) {
        

        let body = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        let url = "\(URLs.authorizationURL)\(Methods.session)"
        
        
        taskForPostMethod(url, headers: [["Accept":"application/json"]], body: body, URLType: "Udacity") { (success, errorString, parsedResult) in
            if let resultHere = parsedResult?["account"] {
                if let accountKey = resultHere?["key"] {
                    self.user["uniqueKey"] = accountKey
                }
                self.getStudentName(sender)
            }
            completionHandlerForAuth(success: success, errorString: errorString)
        }
    }
    
    
    func getStudentLocation(sender: AnyObject, completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) {
        
        let url = "\(URLs.parseURL)\(StudentLocationParameters.limit)\(StudentLocationParameters.descendingOrder)"
        let headers = [
            ["X-Parse-Application-Id":"QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"],
            ["X-Parse-REST-API-Key":"QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"]
        ]
        taskForGETMethod(url, headers: headers ) { (result, error) in
            guard (error == nil) else {
                self.alertMessage("Unable to connect to the internet", sender: sender)
                return
            }
            
            if let students = result["results"] as? [AnyObject] {
                for student in students {
                    let newStudentStruct = StudentInfo(studentDictionary: student as! Dictionary<String, AnyObject>)
                    Students.studentInfoArray.append(newStudentStruct)
                }
            }
            completionHandlerForGET(result: result, error: error)
        }
    }
    
    func getStudentName(sender: AnyObject) {
        let accountK = Client.sharedInstance().user["uniqueKey"]!
        let url = "\(URLs.authorizationURL)/users/\(accountK)"
        
        taskForGETProfile(url) { ( data, response, error) in
            guard (error == nil) else {
                self.alertMessage("Unable to connect to the internet", sender: sender)
                return
            }
            if let user = data!["user"] {
                if let firstName = user!["first_name"] {
                    self.user["firstName"] = firstName
                    Client.sharedInstance().studentFirstName = firstName
                    if let lastName = user!["last_name"] {
                        self.user["lastName"] = lastName
                        Client.sharedInstance().studentLastName = lastName
                    }
                }
            }
        }
    }
    
    
    func postStudentLocation(mediaURL: String, completionHandlerForAuth: (success: Bool, errorString: String?) -> Void) {
        let lat = Client.sharedInstance().inputPlacemark!.coordinate.latitude
        let long = Client.sharedInstance().inputPlacemark!.coordinate.longitude
        let accountK = Client.sharedInstance().user["uniqueKey"]!
        let mapStringLocation = Client.sharedInstance().studentLocation!
        let lastName = Client.sharedInstance().studentLastName!
        let firstName = Client.sharedInstance().studentFirstName!
        
        let body = "{\"uniqueKey\": \"\(accountK)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapStringLocation)\", \"mediaURL\": \"\(mediaURL)\", \"latitude\": \(lat), \"longitude\": \(long)}"
        
        let url = "\(URLs.parseURL)"
        let headers = [
            ["X-Parse-Application-Id":"QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"],
            ["X-Parse-REST-API-Key":"QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"]
        ]
        
        taskForPostMethod(url, headers: headers, body: body, URLType: "Parse") { (success, errorString, parsedResult) in
            completionHandlerForAuth(success: success, errorString: errorString)
        }
    }
    
}
