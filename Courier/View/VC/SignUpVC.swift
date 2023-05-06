//
//  SignUpVC.swift
//  Courier
//
//  Created by Veysal on 1.05.2023.
//

import UIKit

class SignUpVC: BaseVC<SignUpVM>{
    
    //MARK: -- CLOSURES
    
    private lazy var infView: InformationView = {
        var view  = InformationView()
        view.firstLabelText = "Write your phone number"
        view.secondLabelText = "We will send code to your \nphone."
        view.height = height
        view.width = width
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var phoneNumView: EnterPhoneNumberView = {
        var view  = EnterPhoneNumberView()
        view.textFieldPlaceHolder = "Phone number"
        view.mainHeight = height
        view.mainWidth = width
        view.sendCodeBtn.addTarget(self, action: #selector(onTapSend), for: .touchUpInside)
        self.view.addSubview(view)
        return view
    }()
    

    var timer: Timer?
    // MARK: -- FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "Courier"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(onTapBack))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        setup()
        createGesture()
        
       // timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onChange), userInfo: nil, repeats: true)
    }
    
    func createGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapView))
        view.isUserInteractionEnabled = true
       view.addGestureRecognizer(gestureRecognizer)
    }
    
//    @objc func onChange() {
//        print(checkHaveAnAccount())
//
//    }
    //
//    func checkHaveAnAccount() -> Bool {
//        var yes = false
//
//        return yes
//
//    }

    
    @objc func onTapView(){
        view.endEditing(true)
        if phoneNumView.phoneTextField.text == "" {
            phoneNumView.forKeyboardWillHide()
        }
       
    }
    
    @objc func keyboardWillShow() {
        phoneNumView.forKeyboardWillShow()
    }
    
    
    @objc
    func onTapSend() {
        var checkHaveAnAccount = false
        let signInVM = SignInVM()
        let number = "+994\(phoneNumView.phoneTextField.text!)"
        signInVM.getUserInfo().then { result in
                switch result {
                case .success(let model):
                    for data in model {
                        if data.phoneNum.contains(number) {
                            checkHaveAnAccount = true
                            print("you have an account please login")
                        }
                       }
                case .failure(let err):
                    self.makeAlertForWrongCode(with: err.localizedDescription)
                   
                }
              
         }
        
        print("burada")
        if phoneNumView.phoneTextField.text!.count < 9 {
            self.makeAlertForWrongCode(with: "Please input a valid phone number")
        }else {
            if phoneNumView.checkIsNum(phoneNumView.phoneTextField.text!) && !checkHaveAnAccount {
                
                if let text = phoneNumView.phoneTextField.text, !text.isEmpty{
                    print("burada")
                    self.onTapView()
                    UserDefaults.standard.set("+994\(text)", forKey: "number")
                    vm.issignUp(with: "+994\(text)").then { result in
                        switch result {
                        case .success() :
                            DispatchQueue.main.async {
                                self.navigationController?.viewControllers = [self.router.verifyNumVC(num: "+994\(text)")]
                                
                            }
                        case .failure(let err):
                            print(err.localizedDescription)
                            
                        }
                    }
                }
            }
        }
    }
    func setup() {
        infView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(height/5.43)
            make.width.equalTo(width)
            make.height.equalTo(height/5)
        }
        
        phoneNumView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(infView.snp.bottom).offset(height/15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(width)
        }
    }
    

    @objc
    func onTapBack () {
        navigationController?.viewControllers = [router.welcomeVC()]
    }

}
