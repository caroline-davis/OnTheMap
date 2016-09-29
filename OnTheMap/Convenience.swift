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
        
        // Uncomment this when you can to use values you have typed into the login
        //if (username && password) {
            // put the rest of the code from line 23 onwards in here
        //} else {
            //completionHandlerForAuth(success: false, errorString: "Please enter a username and password")
        //}
        
        let u = "caroline_davis@live.com"
        let p = "Rainbow_1"
        let body = "{\"udacity\": {\"username\": \"\(u)\", \"password\": \"\(p)\"}}"
        let url = "\(URLs.AuthorizationURL)\(Methods.Session)"
        print(url)
        taskForPostMethod(url, body: body) { (success, errorString) in
            completionHandlerForAuth(success: success, errorString: errorString)
        }
    }
}


