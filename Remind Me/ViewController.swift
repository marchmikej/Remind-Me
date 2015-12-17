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
        print("about to brint badge # ")
        print(UIApplication.sharedApplication().applicationIconBadgeNumber)
        openWithSafariVC("hi")
    }
    
    @IBAction func openWithSafariVC(sender: AnyObject)
    {
        let svc = SFSafariViewController(URL: NSURL(string: self.urlString)!)
        self.presentViewController(svc, animated: true, completion: nil)
    }

}

