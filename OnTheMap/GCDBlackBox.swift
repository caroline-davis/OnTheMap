//
//  GCDBlackBox.swift
//  OnTheMap
//
//  Created by Caroline Davis on 26/09/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: () -> Void) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}
