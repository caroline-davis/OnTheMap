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
    
    
    
    func postSessionID(username: String, password: String, completionHandlerForAuth: (success: Bool, errorString: String?) -> Void) {
        
        let u = "caroline_davis@live.com"
        let p = "Rainbow_1"
        let body = "{\"udacity\": {\"username\": \"\(u)\", \"password\": \"\(p)\"}}"
        let url = "\(URLs.authorizationURL)\(Methods.session)"
    
        
        taskForPostMethod(url, headers: [["Accept":"application/json"]], body: body) { (success, errorString, parsedResult) in
            if let resultHere = parsedResult?["account"] {
                if let accountKey = resultHere?["key"] {
                    self.user["uniqueKey"] = accountKey
                }
            }
            completionHandlerForAuth(success: success, errorString: errorString)
        }
    }
    
    
    func getStudentLocation(completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) {
        
        let url = URLs.parseURL
        taskForGETMethod(url) { (result, error) in
            if let students = result["results"] as? [AnyObject] {
                for student in students {
                    let newStudentStruct = StudentInfo(studentDictionary: student as! Dictionary<String, AnyObject>)
                    Students.studentInfoArray.append(newStudentStruct)
                }
            }
            completionHandlerForGET(result: result, error: error)
        }
    }
    
    func getStudentName(url: String, completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) {
        
        let url = "\(URLs.authorizationURL)/users/3903878747"
        
    }
    
    
    func postStudentLocation(mediaURL: String, completionHandlerForAuth: (success: Bool, errorString: String?) -> Void) {
        let lat = Client.sharedInstance().inputPlacemark!.coordinate.latitude
        let long = Client.sharedInstance().inputPlacemark!.coordinate.longitude
        let accountK = Client.sharedInstance().user["uniqueKey"]!
        let mapStringLocation = Client.sharedInstance().studentLocation!
        
        let body = "{\"uniqueKey\": \"\(accountK)\", \"firstName\": \"\(StudentInfoKeys.firstName)\", \"lastName\": \"\(StudentInfoKeys.lastName)\",\"mapString\": \"\(mapStringLocation)\", \"mediaURL\": \"\(mediaURL)\", \"latitude\": \(lat), \"longitude\": \(long)}"
        print(body)
        let url = "\(URLs.parseURL)"

        taskForPostMethod(url, headers:[["X-Parse-Application-Id":"QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"],["X-Parse-REST-API-Key":"QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"]], body: body) { (success, errorString, parsedResult) in
            completionHandlerForAuth(success: success, errorString: errorString)
        }
    }

}
