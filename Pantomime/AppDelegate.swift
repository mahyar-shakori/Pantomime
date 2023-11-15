//
//  AppDelegate.swift
//  Pantomime
//
//  Created by MahyR Sh on 4/21/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        
        if UserDefaults.standard.bool(forKey: "isLogin") {
            let rootViewController = storyboard.instantiateViewController(identifier:"Home") as UIViewController
            navigationController.viewControllers = [rootViewController]
            self.window?.rootViewController = navigationController
        }
        else {
            let rootViewController = storyboard.instantiateViewController(identifier:"Intro") as UIViewController
            navigationController.viewControllers = [rootViewController]
            self.window?.rootViewController = navigationController
        }
        return true
    }
}
