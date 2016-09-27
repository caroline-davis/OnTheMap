//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Caroline Davis on 27/09/2016.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tableCell = "locationCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The tableview cell class and its reuse identifier name
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: tableCell)
        
        tableView.delegate = self
        tableView.dataSource = self
    
        }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }

}
