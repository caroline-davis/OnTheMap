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
    
    @IBAction func clickedLogin(sender: AnyObject) {
        Client.sharedInstance().postSessionID(self.username.text!, password: self.password.text!) { (success, errorString) in
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
    
    // When enter is clicked, keyboard toggles down
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Text field turns blank when user clicks on it
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
}
