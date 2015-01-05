//
//  LoginVC.swift
//  AttendanceSystem
//
//  Created by Mohsin on 02/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var lblErrorMsg: UILabel!
    
    @IBOutlet weak var watingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imgBackground: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.watingIndicator.hidden = true
        
        
        self.btnSignIn.layer.cornerRadius = 4.0
        self.btnSignUp.layer.cornerRadius = 4.0
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.imgBackground.image = backgroundImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }
    
    @IBAction func signUP(sender: UIButton) {
        
        self.watingIndicator.hidden = false
        
        let ref = Firebase(url: "https://sweltering-inferno-1689.firebaseio.com")
        
        ref.createUser(self.txtEmail.text, password: self.txtPassword.text,
            withCompletionBlock: { error in
                self.watingIndicator.hidden = true
                
                if error != nil {
                    // There was an error creating the account
                    self.lblErrorMsg.text = error.localizedDescription
                    
                } else {
                    // We created a new user account
                    
                    self.performSegueWithIdentifier("singupSeg", sender: "successfuly sign up")
                    
                    
                }
        })
        
    }
    
    
    @IBAction func signIn(sender: UIButton) {
        
        self.watingIndicator.hidden = false
        
        let ref = Firebase(url: "https://sweltering-inferno-1689.firebaseio.com")
        
        ref.authUser(self.txtEmail.text, password: self.txtPassword.text,
            withCompletionBlock: { error, authData in
                self.watingIndicator.hidden = true
                
                if error != nil {
                    // There was an error logging in to this account
                    self.lblErrorMsg.text = error.localizedDescription
                    
                } else {
                    // We are now logged in
                    var message = "successfuly sign in "
                    message += "\n  User id: \(authData.uid)"
                    let email  = authData.providerData["email"]! as String
                    message += "\n  User email : \(email) "

                    loginUser = WowUser(userName: email, email: email, firstName: "", lastName: "", teams: nil)
                    
                    self.performSegueWithIdentifier("homeSeg", sender: nil)
                    
                }
                
        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "singupSeg" {
            let desVC = segue.destinationViewController as SignupVC
            
            desVC.msg = sender as? String
            
        }
    }
    
    
    
    
    
    @IBAction func passwordEditing(sender: AnyObject) {
        UIView.transitionWithView(self.view, duration: 0.5, options: UIViewAnimationOptions.TransitionNone, animations: {         self.view.frame = CGRect(x: 0, y: -60, width: 320, height: 568)
            }, completion: nil)
    }
    @IBAction func passwordEditingComplete(sender: AnyObject) {
        UIView.transitionWithView(self.view, duration: 0.5, options: UIViewAnimationOptions.TransitionNone, animations: {         self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
            }, completion: nil)
    }

}
