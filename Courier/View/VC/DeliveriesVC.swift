//
//  DeliveriesVC.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import UIKit

class DeliveriesVC: BaseVC<DeliveriesVM> {
    
    private lazy var orderBtn: UIButton = {
       let button = UIButton()
       button.setTitle("Order courier", for: .normal)
       button.clipsToBounds = true
       button.layer.cornerRadius = 4
       button.setTitleColor(UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1), for: .normal)
       button.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
       button.layer.borderWidth = 1
       button.addTarget(self, action: #selector(onTapOrderBtn), for: .touchUpInside)
       return button
    }()
    

    let navBarAppearence = UINavigationBarAppearance()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        notificationSetup()
    }
}
extension DeliveriesVC {

    func notificationSetup() {
        let imgNotification : UIImage = UIImage(named: "notification")!
        let imgMore : UIImage = UIImage(named: "more")!
     
   //     self.navigationController!.navigationBar.tintColor = UIColor.darkText
        self.navigationController!.navigationBar.barStyle = UIBarStyle.black
        self.navigationController!.navigationBar.tintColor = UIColor.darkGray

        

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: imgNotification, style: .plain, target: self, action: #selector(onTapNotification))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imgMore, style: .plain, target: self, action: #selector(onTapMore))

    }
    
    func setup() {
        view.addSubview(orderBtn)
        orderBtn.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.bottom.equalTo(view.snp.bottom).offset(-height/7.5)
            make.height.equalTo(width/6.8)
        }
    }
    
}

extension DeliveriesVC {
    
    @objc func onTapOrderBtn() {
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(router.productInformationVC(), animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    @objc func onTapNotification() {
        let vc : [String:Int] = ["index":2]
        NotificationCenter.default.post(name: Notification.Name("changeIndex"), object: nil, userInfo: vc)
    }
    
    @objc func onTapMore() {
        let vc : [String:Int] = ["index":3]
        NotificationCenter.default.post(name: Notification.Name("changeIndex"), object: nil, userInfo: vc)
    }
    
    
}
