//
//  EnterPhoneNumberView.swift
//  Courier
//
//  Created by Veysal on 4.05.2023.
//

import UIKit

class EnterPhoneNumberView: UIView {
    
    var textFieldPlaceHolder : String?
    var mainWidth : CGFloat?
    var mainHeight : CGFloat?
    
    init(mainWidth: CGFloat, mainHeight: CGFloat) {

        self.mainWidth = mainWidth
        self.mainHeight = mainHeight
        
        super.init(frame: CGRect.zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    lazy var sendCodeBtn: UIButton = {
        let button = UIButton()
        addSubview(button)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        button.setTitle("Send Code", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        return button
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
        textField.attributedPlaceholder = NSAttributedString(string:  "Phone number", attributes:[
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
        sendCodeBtn.removeFromSuperview()
        addSubview(sendCodeBtn)
        sendCodeBtn.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom).offset(mainWidth!/15.6)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.height.equalTo(frame.size.width/6.8)
        }
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
        sendCodeBtn.removeFromSuperview()
        addSubview(sendCodeBtn)
        sendCodeBtn.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.height.equalTo(frame.size.width/6.8)
        }
       
      
        if phoneTextField.text == "" {
            sendCodeBtn.isEnabled = false
            sendCodeBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            phoneTextField.placeholder = "Phone number"
                mainView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
                phoneNumLabel.removeFromSuperview()
        }
    }
  
    
    func setup()  {
        
        mainView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(snp.top).offset(16)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.height.equalTo(mainWidth!/6.8)
        }
        
        sendCodeBtn.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.height.equalTo(frame.size.width/6.8)
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        sendCodeBtn.isEnabled = true
        sendCodeBtn.backgroundColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
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

extension UIView: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let sdcTextField = textField as? SDCTextField {
            return sdcTextField.verifyFields(shouldChangeCharactersIn: range, replacementString: string)
        }
        return false
    }
    
}
