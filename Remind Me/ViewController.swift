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
    
    private var urlString:String = "https://www.tenantsyncdev.com"
    @IBOutlet var respondButtonMessage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("viewcontroller 2")
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
    
    @IBAction func handleNotificationRegistration()  {
        NSLog("handleNotificationRegistration")
        let defaults = NSUserDefaults.standardUserDefaults()
        let token = defaults.objectForKey("token") as? String ?? String()
        let sendURL:String = urlString + "/api/managenotifications/" + token;
        print(sendURL);
        let svc = SFSafariViewController(URL: NSURL(string: sendURL)!)
        self.presentViewController(svc, animated: true, completion: nil)
        /*
        //var myUrl = NSURL(string: "https://www.tenantsyncdev.com/api/registeriapp?email=john@gmail.com&password=hhhhhh&routeId=mikesentagain&type=0");
        var myUrl = NSURL(string: "https://www.tenantsyncdev.com/api/test");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        // Compose a query string
        let postString = "email=john@gmail.com&password=hhhhhh&type=0&routeId=" + token;
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
            print("response = \(response)")
            // Print out response body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            if ((responseString?.containsString("successful")) != false) {
                print("we got it")
            } else {
                print("no go")
            }
        }
        
        task.resume()
*/
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
    
    @IBAction func openWithSafariVC(sender: AnyObject)
    {
        print("opening the url with safarivc")
        //Holding off sarfaiViewController for now
        //let svc = SFSafariViewController(URL: NSURL(string: self.urlString)!)
        //self.presentViewController(svc, animated: true, completion: nil)
        UIApplication.sharedApplication().openURL(NSURL(string: self.urlString)!)
    }
}

