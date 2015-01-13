//
//  ViewController.swift
//  Auth
//
//  Created by Mohsin on 25/12/2014.
//  Copyright (c) 2014 Mohsin. All rights reserved.
//

import UIKit

import SwiftHTTP

class ViewController: UIViewController {
    
    var token : String!

    let ref = Firebase(url: "https://luminous-torch-4640.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       // self.view.transform = CGAffineTransformRotate(self.view.transform, 1.57079633)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func signIn(sender: AnyObject) {
        let url = "http://ubitbcs.freeiz.com/admin.php"
        let url1 = "https://panacloudapi.herokuapp.com/api/signin"
        
        let postString = "admin_username=mohsin&admin_password=mohsin12345"
        let postString1 = "email=ziaukhan@hotmail.com&password=123"
        
/*
        let request = NSMutableURLRequest(URL: NSURL(string: url1)!)
        request.HTTPMethod = "POST"
        
        
        request.HTTPBody = postString1.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
        data, response, error in
        
        if error != nil {
        //println("error=\(error)")
        return
        }
        
        println("response = \(response)")
        
        let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("responseString = \(responseString!)")
            
        }
        task.resume()

*/
        
/*
        
        var request = HTTPTask()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["param": "param1", "array": ["first array element","second","third"], "num": 23, "dict": ["someKey": "someVal"]]
        request.POST("http://domain.com/create", parameters: params, success: {(response: HTTPResponse) in
            
            },failure: {(error: NSError, response: HTTPResponse?) in
                
        })
        */
/*
        var task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://images4.fanpop.com/image/photos/24100000/Roses-from-Princess-yorkshire_rose-24169767-2104-1860.jpg")! ){(data, response, error) in
        
        println("Response: \(response)")
        
        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
        
        println("Body: \(data)\n\n")
        }
        task.resume()
*/


        
        var request = NSMutableURLRequest(URL: NSURL(string: url1)!)
        
        var session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        
        var params = ["email":"ziaukhan@hotmail.com", "password":"123"] as Dictionary
        
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            println("Response: \(response)")
            
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            println("Body: \(strData)\n\n")
            
            var err: NSError?
            
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
            

            let statusCode = json["statusCode"] as? Int
            let statusDesc = json["statusDesc"] as? String

            let user : [String : String]! = json["user"] as? [String : String]
            
            println(" Status Code: \(statusCode!) \n Status Desc: \(statusDesc!)")
            for (key , value) in user!{
                println("\(key) : \(value)")
                
            }
            
            // json = {"response":"Success","msg":"User login successfully."}
            if((err) != nil) {
                
                println(err!.localizedDescription)
                
            }
            
            self.authCustomToken(user["token"])
//                
//            else {
//                
//                var success = json["response"] as? String
//                
//                println("Succes: \(success)")
//                
//                
//                
//                if json["response"] as NSString == "Success"
//                    
//                {
//                    
//                    println("Login Successfull")
//                    
//                }
//                
//                //self.responseMsg=json["msg"] as String
//                
//                dispatch_async(dispatch_get_main_queue(), {
//                    
//                    //    self.loginStatusLB.text=self.responseMsg
//                    
//                })
            
//            }
            
        })
        
        task.resume()
    }


    

    func authCustomToken(token: String!){
        ref.authWithCustomToken(token , withCompletionBlock: { error, authData in
            if error != nil {
                println("Login failed! \(error)")
            } else {
                var expriry : Double = Double(authData.expires)
                var expiresInHrs = (expriry / 60) / 60
                println("Login succeeded! \(authData.uid)")
            }
        })
        
    }

}

