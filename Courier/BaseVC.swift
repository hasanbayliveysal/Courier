//
//  BaseVC.swift
//  Courier
//
//  Created by Veysal on 30.04.2023.
//

import UIKit

class BaseVC<VM>: UIViewController {
    
    var vm: VM
    var router : Router
    var width = CGFloat()
    var height = CGFloat()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        width = view.frame.size.width
        height = view.frame.size.height
  
        let standardAppearance = UINavigationBarAppearance()
           standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
           standardAppearance.configureWithOpaqueBackground()
           standardAppearance.backgroundColor = UIColor.white
           standardAppearance.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: height/33.8, weight: .medium),
            .foregroundColor : UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)]
           self.navigationController?.navigationBar.standardAppearance = standardAppearance
           self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance

    }
    
    init(vm: VM, router: Router) {
        self.vm = vm
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public func makeAlertForWrongCode(with message: String) {
        let alert = UIAlertController(title: nil, message: message , preferredStyle: .alert)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
            alert.dismiss(animated: true)
        })
    }
    
    public func makeAlert(with message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message , preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Ok", style: .default) { _ in
            self.navigationController?.viewControllers = [viewController]
        }
        alert.addAction(okBtn)
        self.present(alert, animated: true)

    }
  
}


