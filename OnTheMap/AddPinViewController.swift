//
//  AddPinViewController.swift
//  OnTheMap
//
//  Created by Caroline Davis on 7/10/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class AddPinViewController: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var pinOnMap: UIButton!
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "buttonClicked" {
            segue.destinationViewController as! AddLinkViewController
        }
    }
    
    @IBAction func clickButton (sender: UIButton!) {
        performSegueWithIdentifier("buttonClicked", sender: self)
        
        }
    
    @IBAction func startOver() {

        }



    
}