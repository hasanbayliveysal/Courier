//
//  SignUpVC.swift
//  Courier
//
//  Created by Veysal on 1.05.2023.
//

import UIKit

class SignUpVC: BaseVC<SignUpVM>{
    
    
    //MARK: -- VARIABLES
    
    let textField = SDCTextField()
    
    
    //MARK: -- CLOSURES
    
    
    private lazy var writeNumLabel: UILabel = {
        var label = UILabel()
        view.addSubview(label)
        label.text = "Write your phone number"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()

    private lazy var informationLabel: UILabel = {
        var label = UILabel()
        view.addSubview(label)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.alpha = 0.3
        label.text = "We will send code to your \nphone."
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()

    private lazy var sendCodeBtn: UIButton = {
        let button = UIButton()
        view.addSubview(button)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        button.setTitle("Send Code", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(onTapSend), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private lazy var orangeView: UIView = {
        
       let view = UIView()
        
        view.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        return view
        
    }()
    
    private lazy var phoneNumLabel: UILabel = {
        let label = UILabel()
       
        label.text = "Phone number"
        label.textColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Courier"
        
        setup()
        createGesture()
        textField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(onTapBack))
        
        navigationItem.leftItemsSupplementBackButton = true
    }
    
    
    //MARK: -- FUNCTIONS
    
    func setup() {
        writeNumLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(height/15)
        }
        informationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(writeNumLabel.snp.bottom).offset(height/33.8)
        }
        createPhoneNumView().snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(informationLabel.snp.bottom).offset(height/10.15)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.height.equalTo(width/6.8)
        }
        sendCodeBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.height.equalTo(width/6.8)
        }
    }
   
    
    
    func createPhoneNumView() -> UIView {
        let view = UIView ()
        self.view.addSubview(view)
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.clipsToBounds = true
      //  view.alpha = 0.3
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        let label = UILabel()
        view.addSubview(label)
        label.text = "+994"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(9)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        
        view.addSubview(textField)
        textField.attributedPlaceholder = NSAttributedString(string: "Phone number", attributes:[
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
        ]
        )
        textField.textColor = .black
        textField.maxLength = 9
        textField.valueType = .phoneNumber
        textField.keyboardType = .phonePad
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.left.equalTo(view.snp.left).offset(72)
            make.right.equalTo(view.snp.right).offset(-16)
        }
        return view
    }

    
    func createGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapView))
        view.isUserInteractionEnabled = true
       view.addGestureRecognizer(gestureRecognizer)
    }

    @objc
    func keyboardWillShow(_ notification: Notification) {
            sendCodeBtn.removeFromSuperview()
            view.addSubview(sendCodeBtn)
            sendCodeBtn.snp.makeConstraints { make in
                make.top.equalTo(informationLabel.snp.bottom).offset(height/5)
                make.left.equalTo(view.snp.left).offset(16)
                make.right.equalTo(view.snp.right).offset(-16)
                make.height.equalTo(width/6.8)
            }
            textField.placeholder = "XX XXX XX XX"
            textField.tintColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)//.cgColor
            self.view.addSubview(orangeView)
            orangeView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(informationLabel.snp.bottom).offset(height/10.15)
                make.left.equalTo(view.snp.left).offset(16)
                make.right.equalTo(view.snp.right).offset(-16)
                make.height.equalTo(width/6.8)
            }
            view.addSubview(phoneNumLabel)
            phoneNumLabel.snp.makeConstraints { make in
                make.centerY.equalTo(orangeView.snp.top)
                make.left.equalTo(orangeView.snp.left).offset(72)
            }
    }
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        sendCodeBtn.isEnabled = true
        sendCodeBtn.backgroundColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
    }
    
    @objc
    func onTapSend() {
        
       // self.navigationController?.viewControllers = [self.router.verifyNumVC(num: "+994000000")]

        if textField.text!.count < 9 {
           print("that is not correctttt")
        }else {
            if checkIsNum(textField.text!) {
                if let text = textField.text, !text.isEmpty {
                    vm.issignUp(with: "+994\(text)").then { result in
                        switch result {
                        case .success():
                            DispatchQueue.main.async {
                                self.navigationController?.viewControllers = [self.router.verifyNumVC(num: "+994\(text)")]
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }

                    }
                }
            } else {
                print("that is not correct")
            }
        }

        
    }
    
    @objc
    func onTapView() {
        view.endEditing(true)
        sendCodeBtn.removeFromSuperview()
        view.addSubview(sendCodeBtn)
        sendCodeBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.height.equalTo(width/6.8)
        }
        textField.placeholder = "Phone number"
            orangeView.removeFromSuperview()
            phoneNumLabel.removeFromSuperview()
        if textField.text == "" {
            sendCodeBtn.isEnabled = false
            sendCodeBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
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
    
    @objc
    func onTapBack () {
        navigationController?.viewControllers = [router.welcomeVC()]
    }

}

extension SignUpVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Verify all the conditions
        if let sdcTextField = textField as? SDCTextField {
            return sdcTextField.verifyFields(shouldChangeCharactersIn: range, replacementString: string)
        }
        return false
    }
        
    
}

