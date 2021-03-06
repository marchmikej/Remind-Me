//
//  AppDelegate.swift
//  Remind Me
//
//  Created by Michael March on 12/15/15.
//  Copyright © 2015 Michael March. All rights reserved.
//

import UIKit
import SafariServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // View controller instance, this is the hook to your ViewController
    var vc = ViewController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let notificationTypes : UIUserNotificationType = [.Alert, .Badge, .Sound]
        let notificationSettings : UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        return true
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings)
    {
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        var deviceTokenString = NSString(format: "%@", deviceToken) as String
        
        deviceTokenString=deviceTokenString.stringByReplacingOccurrencesOfString(" ", withString: "")
        deviceTokenString=deviceTokenString.stringByReplacingOccurrencesOfString("<", withString: "")
        deviceTokenString=deviceTokenString.stringByReplacingOccurrencesOfString(">", withString: "")

        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(deviceTokenString, forKey: "token")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error.localizedDescription)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        // This is called when the app is running and a notification is received
        // If app is not in foreground nothing seems to happen        print("Hi Mike I sent you something!!!1")
        print("Recived: \(userInfo)")
        //Parsing userinfo:
        var temp : NSDictionary = userInfo
        if let info = userInfo["aps"] as? Dictionary<String, AnyObject>
        {

        }
        if let info = userInfo["aps"] as? Dictionary<String, AnyObject>
        {
            let urlMessage = info["url"] as! String
            print("urlMessage");
            print(urlMessage);
            if application.applicationState == UIApplicationState.Inactive || application.applicationState == UIApplicationState.Background {
                //opened from a push notification when the app was on background
                print("from outside app")
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(urlMessage, forKey: "forwardurl")
            } else {
                print("from inside app")
                //vc.showMessageReceivedAlert()
                let alertMsg = info["alert"] as! String
                var alert: UIAlertView!
                alert = UIAlertView(title: "", message: alertMsg, delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        print("exiting1?")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("exiting2?")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        // Resets badge number when you go to app
        print("starting1?")    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        print("starting?")
        vc.shouldForward()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("dying1?")
    }
}

