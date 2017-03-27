//
//  LoginViewController.swift
//  Tenant Sync
//
//  Created by Michael March on 1/29/16.
//  Copyright © 2016 Michael March. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        print("Login View")
        activityIndicator.hidesWhenStopped=true
        let defaults = NSUserDefaults.standardUserDefaults()
        let username = defaults.objectForKey("username") as? String ?? String()
        
        if(username.isEmpty) {
            print("not logged in")
        } else {
            print("logged in")
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.performSegueWithIdentifier("gotosecondscreen", sender: self)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        activityIndicator.stopAnimating()
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("view disapearing")
        email.text=""
        password.text=""
        activityIndicator.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: UIButton) {
        print("new screen")
        print("password")
        print(password.text)
        print("email")
        print(email.text)
        activityIndicator.startAnimating()
        //self.performSegueWithIdentifier("gotosecondscreen", sender: self)
        let myUrl = NSURL(string: "https://app.tenantsync.com/device-api/loginapp");
        //let myUrl = NSURL(string: "https://tenantsyncdev.com/device-api/loginapp");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        // Compose a query string
        //let postString = "email=john@gmail.com&password=hhh5hhh";
        var postString = "email=";
        postString += email.text!;
        postString += "&password=" + password.text!;
        print(postString)
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            self.activityIndicator.stopAnimating()
            // You can print out response object
            //print("response = \(response)")
            // Print out response body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            if ((responseString?.containsString("loggedin")) != false) {
                print("Logged In")
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject(self.email.text, forKey: "username")
                    defaults.setObject(self.password.text, forKey: "password")
                    self.performSegueWithIdentifier("gotosecondscreen", sender: self)
                }
            } else {
                print("no go")
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        task.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
