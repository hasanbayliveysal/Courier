//
//  ProductInformationVC.swift
//  Courier
//
//  Created by Veysal on 15.05.2023.
//

import UIKit

class ProductInformationVC: BaseVC<ProductInformationVM> {
    
    private lazy var productInfo: ProductInformationView = {
       let view = ProductInformationView()
        view.height = height
        view.width = width
        return view
    }()
    
    private lazy var nextButton: UIButton = {
       let button = UIButton()
       button.setTitle("Next", for: .normal)
       button.setTitleColor(UIColor.white, for: .normal)
       button.backgroundColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
       button.clipsToBounds = true
       button.layer.cornerRadius = 4
       button.addTarget(self, action: #selector(onTapNext), for: .touchUpInside)
       return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Courier"
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setup()
        createGestureR()
    
    }
    
    


}
extension ProductInformationVC {
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        productInfo.forKeyboardWillShow()
    }
    @objc func keyboardWillHide(_ notification: NSNotification) {
        productInfo.forkeyboardWillHide()
    }
    
    @objc func onTapNext() {
        self.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(router.productAddressVC(), animated: true)
        navigationItem.backButtonTitle = ""
    }
    
    func createGestureR() {
        let gestureR = UITapGestureRecognizer(target: self, action: #selector(onTapView))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gestureR)
    }

    @objc func onTapView() {
        view.endEditing(true)
    }

    func setup() {
        view.addSubview(productInfo)
        view.addSubview(nextButton)
        productInfo.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(height/5)
            make.height.equalTo(height/2)
        }
        nextButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-32)
            make.height.equalTo(width/6.8)
        }
        
    }
}
