//
//  PhoneNum.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import UIKit

class PhoneNum: UIView {

    var textFieldPlaceHolder : String?
    var mainWidth : CGFloat?
    var mainHeight : CGFloat?
    

    private lazy var mainView: UIView = {
        let view = UIView()
        addSubview(view)
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        return view
    }()

    
    private lazy var myLbl : UILabel = {
        let label = UILabel()
        mainView.addSubview(label)
        label.text = "+994"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    
    lazy var phoneTextField : SDCTextField = {
        let textField = SDCTextField()
        mainView.addSubview(textField)
        textField.attributedPlaceholder = NSAttributedString(string: textFieldPlaceHolder ?? "", attributes:[
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
        ]
        )
        textField.textColor = .black
        textField.maxLength = 9
        textField.valueType = .phoneNumber
        textField.keyboardType = .phonePad
      
        return textField
    }()

    private lazy var phoneNumLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone number"
        label.textColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .white
        return label
    }()
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        phoneTextField.delegate = self
        setup()
    }
    
    func forKeyboardWillShow() {
        phoneTextField.placeholder = "XX XXX XX XX"
        phoneTextField.tintColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)//.cgColor
        mainView.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
        addSubview(phoneNumLabel)
        phoneNumLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mainView.snp.top)
            make.left.equalTo(mainView.snp.left).offset(mainWidth!/5)
        }
    }
    
    func forKeyboardWillHide() {
        phoneTextField.placeholder = "Phone number"
            mainView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
            phoneNumLabel.removeFromSuperview()
    }
  
    
    func setup()  {
        
        mainView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        
         myLbl.snp.makeConstraints { make in
             make.left.equalTo(mainView.snp.left).offset(9)
             make.centerY.equalTo(mainView.snp.centerY)
         }
        
        phoneTextField.snp.makeConstraints { make in
             make.centerY.equalTo(mainView.snp.centerY)
             make.left.equalTo(mainView.snp.left).offset(mainWidth!/5)
             make.right.equalTo(mainView.snp.right).offset(-16)
        }
    }
         
    func checkIsNum(_ num : String) -> Bool {
        let nums = ["10","50","51","55","77","70","40","99"]
        var acceptedNum = ""
        let firstChar = num.first
        acceptedNum.append(firstChar!)
        let secondChar = num.dropFirst().first
        acceptedNum.append(secondChar!)
        let containsCharacter = nums.contains(acceptedNum)
        if containsCharacter {
            return true
        }
        return false
    }

   

}
