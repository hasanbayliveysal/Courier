//
//  ProductAddressView.swift
//  Courier
//
//  Created by Veysal on 23.05.2023.
//


import UIKit

class ProductAddressView : UIView {
    
    var height: CGFloat?
    var width: CGFloat?
    var isSelectedCheckBox = false
    var selectedTf : UITextField?
    
    
    lazy var whereFromTf : SDCTextField = {
      let tf = SDCTextField()
        tf.clipsToBounds = true
        tf.addPadding()
        tf.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        tf.layer.cornerRadius = 5
        tf.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        tf.layer.borderWidth = 0.2
        tf.textAlignment = .natural
        tf.tag = 0
        tf.tintColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        tf.addTarget(self, action: #selector(onTapTf), for: .editingDidBegin)
        let attributedPlaceholder = NSAttributedString(string: "Where From", attributes: [.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25), .font : UIFont.systemFont(ofSize: 16, weight: .regular)])
        tf.attributedPlaceholder = attributedPlaceholder
        return tf
    }()
    
    lazy var whereToTf : SDCTextField = {
      let tf = SDCTextField()
        tf.clipsToBounds = true
        tf.addPadding()
        tf.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        tf.layer.cornerRadius = 5
        tf.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        tf.layer.borderWidth = 0.2
        tf.textAlignment = .natural
        tf.tag = 0
        tf.tintColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        tf.addTarget(self, action: #selector(onTapTf), for: .editingDidBegin)
        let attributedPlaceholder = NSAttributedString(string: "Where To", attributes: [.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25), .font : UIFont.systemFont(ofSize: 16, weight: .regular)])
        tf.attributedPlaceholder = attributedPlaceholder
        return tf
    }()
    
    lazy var checkBox : UIImageView = {
       let icon = UIImageView()
        icon.image = UIImage(named: "unchecked")
        return icon
    }()
    private lazy var nonContactLbl : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Non-contact delivery"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        return label
    }()
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }
    
    func setup(){
        
    }
    
    @objc func onTapTf() {
        
    }
    
}


class RecipientsInformationView: UIView {
    
    
    var height: CGFloat?
    var width: CGFloat?
    var isSelectedCheckBox = false
    var selectedTf : UITextField?
    
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Recipient’s information:"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        return label
    }()
    
    lazy var RecipientsNameTf : SDCTextField = {
      let tf = SDCTextField()
        tf.clipsToBounds = true
        tf.addPadding()
        tf.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        tf.layer.cornerRadius = 5
        tf.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        tf.layer.borderWidth = 0.2
        tf.textAlignment = .natural
        tf.tag = 0
        tf.tintColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        tf.addTarget(self, action: #selector(onTapTf), for: .editingDidBegin)
        let attributedPlaceholder = NSAttributedString(string: "Recipient's name", attributes: [.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25), .font : UIFont.systemFont(ofSize: 16, weight: .regular)])
        tf.attributedPlaceholder = attributedPlaceholder
        return tf
    }()
    
    lazy var RecipientsPhoneNumView : PhoneNum = {
       let view = PhoneNum()
        view.mainHeight = height
        view.mainWidth = width
        return view
    }()

    
  
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }
    
    func setup(){
        
    }
    
    @objc func onTapTf() {
        
    }
    
    
}
