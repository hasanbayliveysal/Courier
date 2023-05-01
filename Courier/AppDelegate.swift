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
        let router = Router()
        let vc = UINavigationController(rootViewController: router.welcomeVC())
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
      
        FirebaseApp.configure()
        
        return true
    }
    
}
 
