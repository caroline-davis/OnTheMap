//
//  Client.swift
//  OnTheMap
//
//  Created by Caroline Davis on 29/09/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit

class Client: NSObject {
    
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }

    
    func taskForPostMethod(url: String, body: String, completionHandlerForPOST: (success: Bool, errorString: String?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        // create network request
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            func sendError(error: String) {
                print(error)
                completionHandlerForPOST(success: false, errorString: error)
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                let code = (response as? NSHTTPURLResponse)?.statusCode
                if code == 403 {
                    sendError("Your username or password is incorrect")
                } else {
                    sendError("Your request returned a status code other than 2xx!")
                }
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            
            
            var parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(newData)'"]
                completionHandlerForPOST(success: false, errorString: String(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
            }
            
            completionHandlerForPOST(success: true, errorString: nil)
            
            
        }
        task.resume()
        
        
    }
    
    // shared instance singleton
    class func sharedInstance() -> Client {
        struct Singleton {
            static var sharedInstance = Client()
        }
        return Singleton.sharedInstance
    }
    
}

   