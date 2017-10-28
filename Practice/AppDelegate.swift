//
//  AppDelegate.swift
//  Practice
//
//  Created by Lu Ao on 10/27/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        Oauth.authorize?.fetchAccessToken(url: url)
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if CurrentUser.currentUser != nil{
            let hamburgerStoryboard = UIStoryboard(name: "Hamburger", bundle: nil)
            let menuStoryboard = UIStoryboard(name: "Menu", bundle: nil)
            let hamburgerViewController = hamburgerStoryboard.instantiateViewController(withIdentifier: "HamburgerViewController") as! HamburgerViewController
            let menuViewController = menuStoryboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            menuViewController.hamburgerViewController = hamburgerViewController
            hamburgerViewController.menuViewController = menuViewController
            window?.rootViewController = hamburgerViewController
        }
        else{
            print("There is no current user")
        }

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: UserAccount.event.didSignOut), object: nil, queue: OperationQueue.main){(Notification) -> Void in
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            self.window?.rootViewController = vc
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

