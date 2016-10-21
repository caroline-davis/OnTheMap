//
//  AddPinViewController.swift
//  OnTheMap
//
//  Created by Caroline Davis on 7/10/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit
import MapKit

class AddPinViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, MKMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterLocation.delegate = self
        activityIndicator.hidesWhenStopped = true
        
      
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
    
    @IBOutlet weak var pinOnMap: UIButton!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var enterLocation: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // Text field turns blank when user clicks on it
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    
    // Saved text from input in variable location
    func textFieldDidEndEditing(textField: UITextField) {
        guard let locationEntry = textField.text where locationEntry != "" else {
            Client.sharedInstance().alertMessage("Please type in a location", sender: self)
            return
        }
        self.findLocation(locationEntry, sender: activityIndicator)
    }
    
    // Changes user input string into long/lat location. Saves this placemark to the shared
    // instance file & calls the segue
    func findLocation(location: String, sender: AnyObject) {
        Client.sharedInstance().studentLocation = location
        activityIndicator.startAnimating()
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, errorString) in
            if (placemarks?.count > 0) {
                let topResult: CLPlacemark = (placemarks?[0])!
                let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                
                Client.sharedInstance().inputPlacemark = placemark
                self.activityIndicator.stopAnimating()
                self.clickDone(self.pinOnMap)
            } else {
                Client.sharedInstance().alertMessage("Geocoding could not be completed", sender: self)
                self.activityIndicator.stopAnimating()
            
            }
        }
    }
    
    // When enter is clicked, keyboard toggles down
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // preparing for segue to the addlink viewcontroller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "findOnMap" {
            segue.destinationViewController as! AddLinkViewController
        }
    }
    
    // func for the segue
    func clickDone (sender: UIButton!) {
        performSegueWithIdentifier("findOnMap", sender: self)
    }
    
    //  func to open addlink viewcontroller screen via clicking the button
    @IBAction func clickFindOnMap (sender: UIButton!) {
        guard let locationEntry = self.enterLocation.text where locationEntry != "" else {
           Client.sharedInstance().alertMessage("Please type in a location", sender: self)
            return
        }
        self.findLocation(locationEntry, sender: activityIndicator)
        }
    
    // cancel func button on nav bar
    @IBAction func cancel() {
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        }
    

    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddPinViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    // When the keyboardWillShow notification is received, shift the view's frame up
    func keyboardWillShow(notification: NSNotification) {
        if self.enterLocation.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification) - 70
        }
    }
    
    func subscribeToKeyboardHideNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddPinViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
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