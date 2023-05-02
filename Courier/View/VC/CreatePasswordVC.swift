//
//  CreatePasswordVC.swift
//  Courier
//
//  Created by Veysal on 3.05.2023.
//

import UIKit

class CreatePasswordVC: BaseVC<CreatePasswordVM> {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "Courier"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(onTapBack))
        
    }
    
    @objc func onTapBack () {
        navigationController?.viewControllers = [router.signUpVC()]
    }
    
    
}
