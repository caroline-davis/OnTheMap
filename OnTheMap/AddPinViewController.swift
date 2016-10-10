//
//  AddPinViewController.swift
//  OnTheMap
//
//  Created by Caroline Davis on 7/10/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class AddPinViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterLocation.delegate = self
    }
    
    @IBOutlet weak var pinOnMap: UIButton!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var enterLocation: UITextField!
    
    
    
    
    
    // When enter is clicked, keyboard toggles down
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Text field turns blank when user clicks on it
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    // preparing for segue to the addlink viewcontroller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "findOnMap" {
            segue.destinationViewController as! AddLinkViewController
        }
    }
    
    //  func to open addlink viewcontroller screen
    @IBAction func clickFindOnMap (sender: UIButton!) {
        performSegueWithIdentifier("findOnMap", sender: self)
        
        }
    
    // cancel func button on nav bar
    @IBAction func cancel() {
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        }



    
}