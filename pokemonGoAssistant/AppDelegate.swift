//
//  AppDelegate.swift
//  pokemonGoAssistant
//
//  Created by Anthony Kim on 7/15/16.
//  Copyright (c) 2016 anthonykim. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager = CLLocationManager()
    var timeInterval = NSDate().timeIntervalSince1970

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let defaults = NSUserDefaults()
        if defaults.stringForKey("user_id") != nil {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil) // this assumes your storyboard is titled "Main.storyboard"
            let yourVC = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            appDelegate.window?.rootViewController = yourVC
            appDelegate.window?.makeKeyAndVisible()
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.locationManager.delegate = self
        print("App entered background")
        if #available(iOS 9.0, *) {
            self.locationManager.allowsBackgroundLocationUpdates = true
        } else {
            // Fallback on earlier versions
        }
        locationManager.distanceFilter = 0
        self.locationManager.startUpdatingLocation()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        self.sendLocationToServer(newLocation)
    }
    
    func sendLocationToServer(location: CLLocation) {
        let newTimeInterval = NSDate().timeIntervalSince1970
        let defaults = NSUserDefaults()
        if defaults.stringForKey("user_id") != nil && newTimeInterval - timeInterval > 60 {
            print("Users location updated to: (" + String(location.coordinate.longitude) + ", " + String(location.coordinate.latitude) + ")")
            Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/notifications/send", parameters: ["user": defaults.stringForKey("user_id")!, "latitude": location.coordinate.latitude, "longitude" : location.coordinate.longitude]).validate().responseJSON { (_, _, response) in
                if let json = response.value {
                    var data = JSON(json)
                    var succesful = data["success"].stringValue
                    if succesful == "1" {
                        //print error message
                    } else {
                        print("Location was sent to server")
                        self.timeInterval = newTimeInterval
                    }
                } else {
                    print("there was a network error while sending location to server")
                }
            }
        }
        
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("Got token data! \(deviceToken)")
        updateDeviceToken(String(stripDT(deviceToken)))
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Couldn't register: \(error)")
    }
    
    func updateDeviceToken(deviceToken: String) {
        let defaults = NSUserDefaults()
        Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/notifications/update_device_token", parameters: ["user": defaults.stringForKey("user_id")!, "dt": deviceToken]).validate().responseJSON { (_, _, response) in
            if let json = response.value {
                var data = JSON(json)
                var succesful = data["success"].stringValue
                if succesful == "1" {
                    //print error message
                } else {
                    print("updating device token was succesful")
                }
            } else {
                print("network error on updating device token")
                print("and this was returned " + String(response.value))
                //network error
            }
        }
    }
    
    func stripDT(deviceToken: NSData) -> String{
        var token = NSString(format: "%@", deviceToken)
        token = token.stringByReplacingOccurrencesOfString("<", withString: "")
        token = token.stringByReplacingOccurrencesOfString(">", withString: "")
        token = token.stringByReplacingOccurrencesOfString(" ", withString: "")
        return token as String
    }

}

