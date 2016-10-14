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
    @IBOutlet weak var errorMessage: UILabel!
    
    
    
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
        textField.text = ""
    }
    
    // Saved text from user input link
    func textFieldDidEndEditing(textField: UITextField) {
        guard let webLink = textField.text where addLink != "" else {
            print("You have not typed in a web address")
            errorMessage.text = "Please add a link"
            return
        }
    }
    

    // cancels pop over and goes back to the map/list view
    @IBAction func cancel() {
        self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
