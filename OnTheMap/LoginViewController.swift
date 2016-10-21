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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.username.delegate = self
        self.password.delegate = self
        

    }
    
    @IBAction func clickedLogin(sender: AnyObject) {
        Client.sharedInstance().postSessionID(self, username: self.username.text!, password: self.password.text!) { (success, errorString) in
                performUIUpdatesOnMain() {
                    if success {
                        self.completeLogin()
                    } else {
                        Client.sharedInstance().alertMessage(errorString!, sender: self)
                    }
                }
            }
        }
    
    private func completeLogin() {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
        presentViewController(controller, animated: true, completion: nil)
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        subscribeToKeyboardHideNotifications()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        unsubscribeFromKeyboardHideNotifications()
    }
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    // When the keyboardWillShow notification is received, shift the view's frame up
    // - Only set for bottom text to make sure top text is always seen
    func keyboardWillShow(notification: NSNotification) {
        if self.password.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification) - 45
        } else if self.username.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification) - 80
        }
    }
    
    func subscribeToKeyboardHideNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardHideNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // When the keyboardWillHide notification is received, shift the view's frame down
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }

    

}
