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

        tabBar.backgroundColor = .white
       // view.backgroundColor = .black
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.tintColor = .orange
        setupVCs()
     
       
       
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                     title: String,
                                                     image: UIImage) -> UIViewController {
           let navController = UINavigationController(rootViewController: rootViewController)
           navController.tabBarItem.title = title
           navController.tabBarItem.image = image
           rootViewController.navigationItem.title = title
           navigationItem.backButtonTitle = ""
           return navController
       }
    
    func setupVCs() {
        let router = Router()
           viewControllers = [
            createNavController(for: router.deliveriesVC(), title: NSLocalizedString("Deliveries", comment: ""), image: UIImage.init(named: "delivery")!),
            createNavController(for: router.addressesVC(), title: NSLocalizedString("Adresses", comment: ""), image: UIImage.init(named: "addresses")!),
            createNavController(for: router.notificationsVC(), title: NSLocalizedString("Notifications", comment: ""), image: UIImage.init(named: "notification")!),
            createNavController(for: router.moreVC(), title: NSLocalizedString("More", comment: ""), image: UIImage.init(named: "more")!)

           ]
       }
    


}
