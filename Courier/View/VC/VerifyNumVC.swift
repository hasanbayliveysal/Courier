//
//  VerifyNumVC.swift
//  Courier
//
//  Created by Veysal on 1.05.2023.
//

import UIKit

class VerifyNumVC: BaseVC<VerifyNumVM> {
    
    //MARK: -- VARIABLES
    
    private lazy var informationLabel: UILabel = {
       let label = UILabel()
        self.view.addSubview(label)
        label.text = "Enter the 6-digit code sent to your \nphone number."
        label.textAlignment = .center
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
   
    private lazy var otpView: OTPView = {
       let view = OTPView()
    
        view.setTimerCounting(vm.userDef)
        view.mainWidth = width
        view.mainHeight = height
        view.sendCodeButton.addTarget(self, action: #selector(onTapSendCodeAgain), for: .allTouchEvents)
        view.t6.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
      
       return view
    }()

    //MARK: -- FUNCTIONS

    override func viewDidLoad() {
        let nc = NotificationCenter.default
//        nc.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
//        nc.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        super.viewDidLoad()
        self.title = "Courier"
        view.backgroundColor = .white
        setup()
        createGesture()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(onTapBack))
        
    }
    
//    @objc func appMovedToBackground() {
//        print("background")
//    }
//
//
//    @objc func appMovedToForeground() {
//        print("Foreground")
//    }
//
//
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }

    func setup() {
     
        self.view.addSubview(otpView)
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(height/4.5)
            make.centerX.equalToSuperview()
        }
        
        otpView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(self.informationLabel.snp.bottom).offset(height/13)
            make.height.equalTo(height/7)
        }
        
    }
    
    @objc func textDidChange() {
        vm.verifyCode(with: otpView.getOTP()).then { result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    if self.vm.forSignIn {
                        self.navigationController?.viewControllers = [TabBar()]
                    }else if self.vm.forNewPassword{
                        self.navigationController?.viewControllers = [self.router.setnewPasswordVC()]
                    }else {
                        self.navigationController?.viewControllers = [self.router.createPasswordVC()]
                    }
                }
            case .failure(let err):
                self.otpView.clearAllTextField()
                self.makeAlertForWrongCode(with: err.localizedDescription)
            }
        }
    }
    
    
    @objc
    func onTapBack () {
        navigationController?.viewControllers = [router.signUpVC()]
    }
    func createGesture() {
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(onTapMainView))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gestureRec)
    }
    @objc func onTapMainView() {
        view.endEditing(true)
    }
    
    @objc func onTapSendCodeAgain() {
        vm.issignUp(with: vm.number).then { result in
            switch result {
            case .success():
                self.makeAlertForWrongCode(with: "Code Sended Again")
            case .failure(let err):
                self.makeAlertForWrongCode(with: err.localizedDescription)
                
                
            }
        }
    }
}
