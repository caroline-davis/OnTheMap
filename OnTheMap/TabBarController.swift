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
            print("No view lad")
        }
    }
}