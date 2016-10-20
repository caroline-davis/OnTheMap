//
//  AddLinkViewController.swift
//  OnTheMap
//
//  Created by Caroline Davis on 7/10/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit
import MapKit

class AddLinkViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var addLink: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLink.delegate = self
        
        var region: MKCoordinateRegion = self.mapView.region
        
        region.center.latitude = (Client.sharedInstance().inputPlacemark!.coordinate.latitude)
        region.center.longitude = (Client.sharedInstance().inputPlacemark!.coordinate.longitude)
        
        region.span = MKCoordinateSpanMake(0.5, 0.5)
        
        self.mapView.setRegion(region, animated: true)
        self.mapView.addAnnotation(Client.sharedInstance().inputPlacemark!)
    }
    
    
    // When enter is clicked, keyboard toggles down
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Text field turns blank when user clicks on it
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = "https://www."
    }
    
    // Saved text from user input link
    func textFieldDidEndEditing(textField: UITextField) {
        guard let webLink = textField.text where addLink != "" else {
            Client.sharedInstance().alertMessage("Please add a link", sender: self)
            return
        }
    }
    
    @IBAction func pressSumbit (sender: AnyObject) {
        var webLink = addLink.text
        Client.sharedInstance().postStudentLocation(webLink!) { (success, errorString) in
            performUIUpdatesOnMain() {
                if success {
                    print(success)
                    let controller = self.storyboard?.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
                    self.presentViewController(controller, animated: true, completion: nil)
                } else {
                    Client.sharedInstance().alertMessage(errorString!, sender: self)
                }
            }
        }
    }



    // cancels pop over and goes back to the map/list view
    @IBAction func cancel() {
        self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
