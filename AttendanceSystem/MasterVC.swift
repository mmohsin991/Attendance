//
//  MasterVC.swift
//  AttendanceSystem
//
//  Created by Mohsin on 01/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class MasterVC: UITableViewController, UISplitViewControllerDelegate {

    var tempData = ["Home","Teams","Preferences"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)

                
        performSegueWithIdentifier("showDetail", sender: 0)
        
        // select row 1st row as default row
        // self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.None)

    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.backgroundView = backgroundImageView
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("showDetail", sender: indexPath.row)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.tempData.count
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPathForRow = sender as Int
        
        if segue.identifier == "showDetail" {
            
            // Home View Controller
            if indexPathForRow == 0{
                
                //1. Put the secondary view controller in a variable called vc
                let vc = (segue.destinationViewController as UINavigationController).topViewController as HomeVC
                
            }
            
            // Teams View Controller
            else if indexPathForRow == 1{
                // set the apprpriate view controller to the root navigation view controller
                (segue.destinationViewController as UINavigationController).viewControllers[0] = self.storyboard?.instantiateViewControllerWithIdentifier("teamsID") as TeamsVC
                
                //1. Put the secondary view controller in a variable called vc
                let vc = (segue.destinationViewController as UINavigationController).topViewController as TeamsVC
                
            }
            
            // Preferences View Controller
            else if indexPathForRow == 2{
                // set the apprpriate view controller to the root navigation view controller
                (segue.destinationViewController as UINavigationController).viewControllers[0] = self.storyboard?.instantiateViewControllerWithIdentifier("preferencesID") as PreferencesVC
                
                //1. Put the secondary view controller in a variable called vc
                let vc = (segue.destinationViewController as UINavigationController).topViewController as PreferencesVC
                
            }
            

        
       }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell


        cell.textLabel?.text = self.tempData[indexPath.row]
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        
        cell.separatorInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        
        
        // Configure the cell selection color
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        cell.selectedBackgroundView = backgroundColorView
        
        return cell
    }



}
