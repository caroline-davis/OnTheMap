//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Caroline Davis on 22/09/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
 
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var debugError: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.username.delegate = self
        self.password.delegate = self
    }

    
    // When enter is clicked, keyboard toggles down
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Text field turns blank when user clicks on it
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    @IBAction func clickedLogin(sender: AnyObject) {
            self.postSessionID() { (success, errorString) in
                performUIUpdatesOnMain() {
                    if success {
                        self.completeLogin()
                    } else {
                        self.displayError(errorString)
                    }
                }
            }
        }
    
    
    
    private func completeLogin() {
        debugError.text = ""
        let controller = storyboard!.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
        presentViewController(controller, animated: true, completion: nil)
    }
    
    // if the username or password is incorrect the error comes up
    private func displayError(errorString: String?) {
        if let errorString = errorString {
            debugError.text = errorString
        }
    }

    
     func postSessionID(completionHandlerForPOST: (success: Bool, errorString: String?) -> Void) {
        // CHANGE THIS LATER,should be self.username.text!and self.password.text!
        
        //if (self.username.text!and self.password.text!)
        let u = "caroline_davis@live.com"
        let p = "Rainbow_12222"
    // create url and request
    let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
    request.HTTPMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = "{\"udacity\": {\"username\": \"\(u)\", \"password\": \"\(p)\"}}".dataUsingEncoding(NSUTF8StringEncoding)


    // create network request
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request) { data, response, error in
        
        func sendError(error: String) {
            let userInfo = [NSLocalizedDescriptionKey : error]
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
    
    
}
