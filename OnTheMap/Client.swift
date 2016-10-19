//
//  Client.swift
//  OnTheMap
//
//  Created by Caroline Davis on 29/09/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import MapKit

class Client: NSObject {
    
    // empty var for placemark on addpin viewcontroller
    var inputPlacemark: MKPlacemark?
    
    // empty var for users unique key
    var user = [String:AnyObject]()
    
    // empty var for users study location
    var studentLocation: String?
    
    // empty var for users first name
    var studentFirstName: AnyObject?
    
    // empty var for users last name
    var studentLastName: AnyObject?
    
    // initializers
    override init() {
        super.init()
    }
        // adding parameters: method: String and parameters: [String:AnyObject]
    func taskForGETMethod(url: String, headers: [[String:String]]?, completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* 1. Set the parameters */
    
 
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        if (headers != nil) {
            for header in headers! {
                for (key, value) in header {
                    request.addValue(value, forHTTPHeaderField: key)
                }
            }
        }
        
        
        let session = NSURLSession.sharedSession()

        
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }

            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }

    
    func taskForPostMethod(url: String, headers: [[String:String]], body: String, URLType: String, completionHandlerForPOST: (success: Bool, errorString: String?, parsedResult: AnyObject? ) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        for header in headers {
            for (key, value) in header {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        // create network request
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            func sendError(error: String) {
                print(error)
                completionHandlerForPOST(success: false, errorString: error, parsedResult: nil)
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
            var newData: NSData?
            if URLType == "Udacity" {
                newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            } else {
                newData = data
                
            }
            
            // parse the data
            var parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(newData!, options: .AllowFragments)
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(newData)'"]
                completionHandlerForPOST(success: false, errorString: String(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo), parsedResult: nil)
            }
            
            // else call the function
            completionHandlerForPOST(success: true, errorString: nil, parsedResult: parsedResult)
            
        }
        task.resume()

    }
    
    func taskForGETProfile(url: String, completionHandlerForGET: (data: AnyObject?, response: AnyObject?, error: NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(data: nil, response: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
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
                print(parsedResult)
            }
            completionHandlerForGET(data: parsedResult, response: true, error: nil)
        }
         task.resume()
    }
    
    
    // given raw JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }

        
        completionHandlerForConvertData(result: parsedResult, error: nil)
    }
    
    func taskToDeleteSession(completionHandlerForDELETE: (success: Bool, errorString: String?) -> Void) {
        
        
         /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "DELETE"
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = NSURLSession.sharedSession()
        
         /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) { data, response, error in
                
            func sendError(error: String) {
                print(error)
                completionHandlerForDELETE(success: false, errorString: error)
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            print(data)
            
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
            
            completionHandlerForDELETE(success: true, errorString: nil)
        }
        task.resume()
    }
    
    // alert message pop ups
    func alertMessage(errorMessage: String, sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            print("Cancel")
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            
            guard result != false else {
                print("OK")
                return
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        sender.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    // shared instance singleton
    class func sharedInstance() -> Client {
        struct Singleton {
            static var sharedInstance = Client()
        }
        return Singleton.sharedInstance
    }
    
    
    
}

   