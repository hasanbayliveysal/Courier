//
//  AppDelegate.swift
//  Courier
//
//  Created by Veysal on 30.04.2023.
//

import UIKit
import CoreData
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
//
//    URLCache.shared.removeAllCachedResponses()
//    URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 2.0)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        let router = Router()
        if Auth.auth().currentUser == nil {
            let navVC = UINavigationController(rootViewController: router.welcomeVC())
            self.window?.rootViewController = navVC
        } else {
            let navVC =  UINavigationController(rootViewController:  router.welcomeVC())
            self.window?.rootViewController = navVC
        }
      
        self.window?.makeKeyAndVisible()
        return true
    }
    
}
 
