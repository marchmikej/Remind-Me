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
    
    private var urlString:String = "http://rootedindezign.com"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let token = defaults.objectForKey("token") as? String ?? String()
        if token.isEmpty {
            print("Device Token not available")
            print(token)
        } else {
            print(token)
        }
        var count: Int = defaults.integerForKey("count")
        count++
        defaults.setInteger(count, forKey: "count")
        print(defaults.integerForKey("count"))
        openWithSafariVC("hi")
    }
    
    @IBAction func openWithSafariVC(sender: AnyObject)
    {
        let svc = SFSafariViewController(URL: NSURL(string: self.urlString)!)
        self.presentViewController(svc, animated: true, completion: nil)
    }

}

