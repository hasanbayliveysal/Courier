//
//  TabBar.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import UIKit

class TabBar: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVCs()
        
    }
    
//    func setupVCs(){
//        let router = Router()
//        self.view.backgroundColor = .white
//        tabBar.tintColor = UIColor(named:"PurpleC")
//        tabBar.backgroundColor = .white
//        tabBar.layer.borderWidth = 1
//        tabBar.layer.borderColor = UIColor(white: 0.8, alpha: 0.8).cgColor
//        navigationItem.backButtonTitle = ""
//
//
//        router.deliveriesVC().tabBarItem = UITabBarItem(title: "", image: UIImage.init(named: "delivery")!, selectedImage: UIImage.init(named: "delivery")!)
//        router.addressesVC().tabBarItem = UITabBarItem(title: "", image: UIImage.init(named: "addresses")!, selectedImage: UIImage.init(named: "addresses")!)
//        router.notificationsVC().tabBarItem = UITabBarItem(title: "", image: UIImage.init(named: "notification")!, selectedImage: UIImage.init(named: "notification")!)
//        router.moreVC().tabBarItem = UITabBarItem(title: "", image: UIImage.init(named: "more")!, selectedImage: UIImage.init(named: "more")!)
//
//    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        rootViewController.navigationItem.backButtonTitle = ""
        return navController
    }
    
    func setupVCs() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeIndex), name: Notification.Name("changeIndex"), object: nil)
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.tintColor = .orange
        let router = Router()
        viewControllers = [
            createNavController(for: router.deliveriesVC(), title: NSLocalizedString("Deliveries", comment: ""), image: UIImage.init(named: "delivery")!),
            createNavController(for: router.addressesVC(), title: NSLocalizedString("Address", comment: ""), image: UIImage.init(named: "addresses")!),
            createNavController(for: router.notificationsVC(), title: NSLocalizedString("Notification", comment: ""), image: UIImage.init(named: "notification")!),
            createNavController(for: router.moreVC(), title: NSLocalizedString("More", comment: ""), image: UIImage.init(named: "more")!),
        ]
    }
    
    @objc func changeIndex(_ notification: NSNotification) {
        let index = notification.userInfo?["index"] as! Int
        self.selectedIndex = index
    }
}
    
