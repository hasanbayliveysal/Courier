//
//  ForgotPasswordVC.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import UIKit
import FirebaseFirestore

class ForgotPasswordVC: BaseVC<ForgotPasswordVM> {
    let db = Firestore.firestore()
    
    private lazy var infoView : InformationView = {
        let view = InformationView()
        view.height = height
        view.width = width
        view.firstLabelText = "Forgot your password?"
        view.secondLabelText = "We will send code to your \nphone."
        return view
    }()
    
    private lazy var enterPhoneNumView: EnterPhoneNumberView = {
        let view = EnterPhoneNumberView(mainWidth: width, mainHeight: height)
        view.sendCodeBtn.addTarget(self, action: #selector(onTapSend), for: .touchUpInside)
        return view
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Courier"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(onTapBack))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        setup()
        createGesture()
    }
    
     
    

    
    
}

extension ForgotPasswordVC {
    
    func setup() {
        self.view.addSubview(infoView)
        self.view.addSubview(enterPhoneNumView)
        infoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.snp.top).offset(height/5.43)
            make.height.equalTo(height/5)
        }
        
        enterPhoneNumView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(infoView.snp.bottom).offset(height/15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(width)
        }
        
    }
    
    func createGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapView))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gestureRecognizer)
    }
  
    func sendVerificationCode(num: String) {
        let signUpVM = SignUpVM()
        self.onTapView()
        signUpVM.issignUp(with: "+994\(num)").then({ res in
                switch res {
                case .success():
                    self.navigationController?.viewControllers = [self.router.verifyNumVC(num: "+994\(num)", userDef: true, false, true)]
                case .failure(let err):
                    self.makeAlertForWrongCode(with: err.localizedDescription)
                }
            })
        
    }
    
}

extension ForgotPasswordVC {
    
    @objc func onTapBack() {
        navigationController?.viewControllers = [router.signInVC(afterSetPassword: false)]
    }
    
    @objc func onTapView(){
        view.endEditing(true)
        enterPhoneNumView.forKeyboardWillHide()
       
    }
    
    @objc func keyboardWillShow() {
        enterPhoneNumView.forKeyboardWillShow()
    }
    
    
    
    @objc func onTapSend() {
        let signInVM = SignInVM(afterSetPassword: false)
        if let num = enterPhoneNumView.phoneTextField.text, enterPhoneNumView.checkIsNum(num) {
            UserDefaults.standard.set("+994\(num)", forKey: "numforchangepassword")
            var userValid : [Bool] = []
            signInVM.getUserInfo().then { res in
                switch res {
                case .success(let model):
                    DispatchQueue.main.async {
                        for data in model {
                            if data.phoneNum == "+994\(num)" {
                                userValid.append(true)
                                break
                            }
                        }
                        if userValid.contains(true){
                            self.sendVerificationCode(num: num)
                        }else {
                            self.makeAlertForWrongCode(with: "You don't have an account please Sign up")
                        }
                    }
                case .failure(let err):
                    self.makeAlertForWrongCode(with: err.localizedDescription)
                }
            }

        }
    }
    
}
