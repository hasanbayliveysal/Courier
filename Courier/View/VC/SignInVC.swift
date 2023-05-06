//
//  SignInVC.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import UIKit
import FirebaseFirestore

class SignInVC: BaseVC<SignInVM> {
    var isUserValid = false
    let db = Firestore.firestore()
    var selecedIsPasswordView = false
    
    private lazy var infView : InformationView = {
        let view = InformationView()
        view.height = self.view.frame.size.height
        view.width = self.view.frame.size.width
        view.firstLabelText = "Glad to see you again!"
        view.secondLabelText = "Sign in and continue to delivery your \nluggage! "
        return view
    }()
    
    private lazy var passwordView: PasswordView = {
        let view = PasswordView(height: height, width: width)
        view.tfPlaceHolder = "Password"
        view.tf.addTarget(self, action: #selector(onTapPasswordView), for: .allTouchEvents)
        view.forCreatePassword = true
        return view
    }()
    
    private lazy var phoneNumView: PhoneNum = {
        let view = PhoneNum()
        view.mainWidth = width
        view.mainHeight = height
        view.textFieldPlaceHolder = "Phone number"
        view.phoneTextField.addTarget(self, action: #selector(onTapPhoneNumView), for: .allTouchEvents)
        
        return view
    }()
    
    private lazy var signInButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        button.setTitle("Sign In", for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(onTapSignIn), for: .touchUpInside)
        button.layer.cornerRadius = 4
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setup()
        addGesture()
        self.title = "Courier"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(onTapBack))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if selecedIsPasswordView {
            passwordView.keyboardWillShow()
            if phoneNumView.phoneTextField.text == ""{
                phoneNumView.forKeyboardWillHide()
            }
        } else {
        
            phoneNumView.forKeyboardWillShow()
          
            if passwordView.tf.text == "" {
                passwordView.keyboardWillHide()
            }
        }
       
       
        
    }
    @objc func keyboardWillHide(sender: NSNotification) {
        if phoneNumView.phoneTextField.text == ""{
            phoneNumView.forKeyboardWillHide()
        }
        if passwordView.tf.text == "" {
            passwordView.keyboardWillHide()
        }
       
        
    }
    @objc func onTapPhoneNumView() {
        selecedIsPasswordView = false
    }
    
    @objc func onTapPasswordView() {
        selecedIsPasswordView = true
    }
    
    
    
    func addGesture() {
        let gestureForView = UITapGestureRecognizer(target: self, action: #selector(onTapView))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gestureForView)
    }
    
    @objc func onTapView() {
        view.endEditing(true)
    }
    
    @objc func onTapSignIn() {
        
        if passwordView.tf.text != "" && phoneNumView.phoneTextField.text != "" {
          
         //   var myData : [UserModel] = []
            vm.getUserInfo().then { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        for info in data {
                            if let number = self.phoneNumView.phoneTextField.text {
                                if info.phoneNum == "+994\(number)" && info.password == self.passwordView.tf.text {
                                    self.isUserValid = true
                                    break
                                }
                            }
                        }
                    }
                    if self.isUserValid {
                        self.navigationController?.viewControllers = [TabBar()]
                    } else {
                        self.makeAlertForWrongCode(with: "There is no user in this criterias")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
           // print(myData)
        } else {
            print("sehvdi")
        }
        
    }
    
    
    func setup(){
        self.view.addSubview(signInButton)
        self.view.addSubview(infView)
        self.view.addSubview(phoneNumView)
        self.view.addSubview(passwordView)
        infView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(height/5.43)
            make.width.equalTo(width)
            make.height.equalTo(height/5)
        }
        phoneNumView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(infView.snp.bottom).offset(height/17)
            make.height.equalTo(height/17)
        }
        passwordView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(phoneNumView.snp.bottom).offset(height/51)
            make.height.equalTo(height/17)
        }
        signInButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(width/6.8)
            make.top.equalTo(passwordView.snp.bottom).offset(height/11)
        }
        
        
        
    }
    

    
    @objc func onTapBack() {
        navigationController?.viewControllers = [router.welcomeVC()]
    }


}
