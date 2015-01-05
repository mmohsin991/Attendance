//
//  SignupVC.swift
//  AttendanceSystem
//
//  Created by Mohsin on 02/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    
    var msg: String!
    var status: String!
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var imgBackground: UIImageView!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        btnBack.layer.cornerRadius = 4.0
        if msg != nil {
            self.txtMessage.text = self.msg
        }
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.imgBackground.image = backgroundImage
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject) {
        // performSegueWithIdentifier("backSeg", sender: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    


}
