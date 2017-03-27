//
//  ViewController.swift
//  Remind Me
//
//  Created by Michael March on 12/15/15.
//  Copyright © 2015 Michael March. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    @IBAction func notificationToggled(sender: UISwitch) {
        print("notificationToggled")
        if(receiveNotifications.on) {
            getNotificationStatus("turnon")
        } else {
            getNotificationStatus("turnoff")
        }
    }
    @IBOutlet weak var receiveNotifications: UISwitch!
       
    private var urlString:String = "https://app.tenantsync.com"
    //private var urlString:String = "https://tenantsyncdev.com"
    @IBOutlet var respondButtonMessage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("viewcontroller 2")
        getNotificationStatus("NO")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //let defaults = NSUserDefaults.standardUserDefaults()
        //let token = defaults.objectForKey("token") as? String ?? String()
        //if token.isEmpty {
         //   print("Device Token not available")
        //    print(token)
        //} else {
        //    print(token)
       // }
        print("viewcontroller 1")
    }
    
    @IBAction func handleRespondToMessageButton() {
        print("responding to users response")
        let defaults = NSUserDefaults.standardUserDefaults()
        let urlforward = defaults.objectForKey("forwardurl") as? String ?? String()
        let sendURL:String = urlString + "/" + urlforward;
        print("going to url")
        print(sendURL)
        let svc = SFSafariViewController(URL: NSURL(string: sendURL)!)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    func goToSite()  {
        NSLog("goToSite")
        openWithSafariVC("hi")
    }

    func goToURL(urlForward: String)  {
        print("goToURL")
        print(urlForward)
        UIApplication.sharedApplication().openURL(NSURL(string: self.urlString)!)
    }
    
    func shouldForward() {
        print("In should forward")
        let defaults = NSUserDefaults.standardUserDefaults()
        let urlforward = defaults.objectForKey("forwardurl") as? String ?? String()

        if(urlforward != "noforward" && !urlforward.isEmpty) {
            print("forwarding to site")
            defaults.setObject("noforward", forKey: "forwardurl")
            let sendURL:String = urlString + "/" + urlforward;
            print(sendURL)
            UIApplication.sharedApplication().openURL(NSURL(string: sendURL)!)
        } else {
            print("not forwarding to site")
        }
    }
    
    func showMessageReceivedAlert() {
        let alertController = UIAlertController(title: "New Message", message: "Here is your message", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func getNotificationStatus(update:String) {
        print("update")
        print(update)
        let defaults = NSUserDefaults.standardUserDefaults()
        let username = defaults.objectForKey("username") as? String ?? String()
        let password = defaults.objectForKey("password") as? String ?? String()
        let token = defaults.objectForKey("token") as? String ?? String()
        print("password")
        print(password)
        print("token")
        print(token)
        if(!username.isEmpty || !password.isEmpty) {
            let myUrl = NSURL(string: "https://app.tenantsync.com/device-api/receivingnotifications");
            //let myUrl = NSURL(string: "https://tenantsyncdev.com/device-api/receivingnotifications");
            let request = NSMutableURLRequest(URL:myUrl!);
            request.HTTPMethod = "POST";
            // Compose a query string
            var postString = "email=";
            postString += username;
            postString += "&password=" + password;
            postString += "&routeid=" + token
            postString += "&verify=" + update
            print(postString)
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil
                {
                    print("error=\(error)")
                    return
                }
                // You can print out response object
                //print("response = \(response)")
                // Print out response body
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    if ((responseString?.containsString("loginfailed")) != false) {
                        print("Not logged in")
                        self.logout()
                    } else if ((responseString?.containsString("notificationon")) != false) {
                        print("notifcationson")
                        self.receiveNotifications.setOn(true, animated:true)
                    } else if ((responseString?.containsString("notficationoff")) != false) {
                        print("notificationsoff")
                        self.receiveNotifications.setOn(false, animated:true)
                    } else {
                        print("error")
                        self.receiveNotifications.setOn(false, animated:true)
                    }
                    print("here we are")
                }
            }
            task.resume()
        } else {
            print("not logged in")
            logout()
        }
    }
    
    func logout() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("", forKey: "username")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func logoutClicked(sender: UIButton) {
        logout()
    }
    
    @IBAction func openWithSafariVC(sender: AnyObject)
    {
        print("opening the url with safarivc")
        //Holding off sarfaiViewController for now
        //let svc = SFSafariViewController(URL: NSURL(string: self.urlString)!)
        //self.presentViewController(svc, animated: true, completion: nil)
        UIApplication.sharedApplication().openURL(NSURL(string: self.urlString)!)
    }
}

