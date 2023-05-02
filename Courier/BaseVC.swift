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
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 24, weight: .medium),
            .foregroundColor : UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        ]
        
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)

    }
    
    init(vm: VM, router: Router) {
        self.vm = vm
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  
}


