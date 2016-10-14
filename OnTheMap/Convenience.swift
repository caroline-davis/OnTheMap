//
//  Convenience.swift
//  OnTheMap
//
//  Created by Caroline Davis on 29/09/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit

extension Client {
    
    func postSessionID(username: String, password: String, completionHandlerForAuth: (success: Bool, errorString: String?) -> Void) {

        
        let u = "caroline_davis@live.com"
        let p = "Rainbow_1"
        let body = "{\"udacity\": {\"username\": \"\(u)\", \"password\": \"\(p)\"}}"
        let url = "\(URLs.authorizationURL)\(Methods.session)"
        
        taskForPostMethod(url, body: body) { (success, errorString) in
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
    
}
