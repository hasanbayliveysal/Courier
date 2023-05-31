//
//  MoreVC.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import UIKit

class MoreVC: BaseVC<MoreVM> {
    
 
    private lazy var logOutBtn: UIButton = {
       let button = UIButton()
        button.setTitle("Log out", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.orange, for: .normal)
        button.addTarget(self, action: #selector(onTapLogOut), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .white
     
        
    }
   
    
 
}
extension MoreVC {
    
    @objc func onTapLogOut() {
        createAlert()

    }
    
}

extension MoreVC {
    func setup() {
        view.addSubview(logOutBtn)
        logOutBtn.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
    }
    
    
    func logOut() {
        vm.logOut().then { res in
            switch res {
            case .success():
                self.navigationController?.viewControllers = [self.router.welcomeVC()]
            case .failure(let err):
                self.makeAlertForWrongCode(with: err.localizedDescription)
            }
        }
    }

    func createAlert() {
        let alert = UIAlertController(title: "Log out", message: "Do you want to log out?", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Ok", style: .default) { _ in
            self.logOut()
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okBtn)
        alert.addAction(cancelBtn)
        self.present(alert, animated: true)
    }
    
}

