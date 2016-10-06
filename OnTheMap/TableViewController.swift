//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Caroline Davis on 27/09/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // reuse identifier
    var tableCell = "locationCell"
    
    // data for the table
    var locationInfo: [Client.StudentInfo] {
        return Students.studentInfoArray
    }
    
    //Students.studentInfoArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(locationInfo, "hi")
        
        // The tableview cell class and its reuse identifier name
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: tableCell)
        
        tableView.delegate = self
        tableView.dataSource = self
    
        }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationInfo.count
    }
    
    override func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.tableCell)!
        let studentStruct = self.locationInfo[indexPath.row]

       
        cell.textLabel?.text = ("\(studentStruct.firstName!) \(studentStruct.lastName!)")
       // cell.detailTextLabel?.text = ("\(studentStruct.firstName!) \(studentStruct.lastName!)")
        
        return cell
        }
    
    
    // when the button is pressed the url opens in safari
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let studentStruct = self.locationInfo[indexPath.row]
            let app = UIApplication.sharedApplication()
            app.openURL(NSURL(string: studentStruct.mediaURL!)!)

    }
    
}
