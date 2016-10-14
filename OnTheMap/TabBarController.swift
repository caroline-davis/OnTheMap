//
//  TabBarController.swift
//  OnTheMap
//
//  Created by Caroline Davis on 11/10/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var logOut: UIBarButtonItem!
    
    @IBAction func refreshButton(sender: UIBarButtonItem) {
        refreshSelectedViewController()
    }
    
    func refreshSelectedViewController() {
        if self.selectedViewController!.isKindOfClass(MapViewController) {
            let controller = self.selectedViewController as! MapViewController
            controller.refresh()
        } else if self.selectedViewController!.isKindOfClass(TableViewController) {
            let controller = self.selectedViewController as! TableViewController
            controller.refresh()
        } else {
            print("Not able to refresh at this time")
        }
    }
    
    @IBAction func logMeOut(sender: UIBarButtonItem) {
        Client.sharedInstance().taskToDeleteSession() { (success, errorString) in
            if success {
                dispatch_async(dispatch_get_main_queue()){
                    self.dismissViewControllerAnimated(true, completion: nil)
                }

            } else {
                print(errorString)
            }
        }
    }
}
