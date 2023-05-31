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
    var myViews : [AnyObject] = []
    var keyboardHeight: CGFloat?
    
    private lazy var infView : InformationView = {
        let view = InformationView()
        view.height = self.view.frame.size.height
        view.width = self.view.frame.size.width
        view.firstLabelText = "Glad to see you again!"
        view.secondLabelText = "Sign in and continue to delivery your \nluggage! "
        return view
    }()
    
    private lazy var passwordView: PasswordView = {
        let view = PasswordView()
        view.width = width
        view.height = height
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

    private lazy var forgotPasswordButton : UILabel = {
       let label = UILabel()
        label.text = "Forgot password?"
        label.textColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    private lazy var donthaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don’t have an account? "
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        label.font = UIFont.systemFont(ofSize: height/67.6, weight: .regular)
        return label
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up"
        label.textColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        label.font = UIFont.systemFont(ofSize: height/60, weight: .regular)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myViews.append(infView)
        myViews.append(passwordView)
        myViews.append(signInButton)
        myViews.append(phoneNumView)
        myViews.append(forgotPasswordButton)
        myViews.append(donthaveAccountLabel)
        myViews.append(signUpLabel)
        setup()
        addGesture()
        self.title = "Courier"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(onTapBack))
     
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    

}
extension SignInVC {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    func addGesture() {
        let gestureForView = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer))
        gestureForView.name = "view"
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gestureForView)
        
        let gestureForForgotPassword = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer))
        gestureForForgotPassword.name = "forgotPassword"
        forgotPasswordButton.isUserInteractionEnabled = true
        forgotPasswordButton.addGestureRecognizer(gestureForForgotPassword)
        
        let gestureForSignUp = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer))
        gestureForSignUp.name = "signup"
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(gestureForSignUp)
    }
    
   
    
    
    func setup(){
        for view in myViews {
            guard let view = view as? UIView else {return}
            self.view.addSubview(view)
        }
        infView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(height/5.43)
            make.width.equalTo(width)
            make.height.equalTo(height/5)
        }
        phoneNumView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        //    make.top.equalTo(infView.snp.bottom).offset(height/17)
            make.bottom.equalTo(passwordView.snp.top).offset(-height/51)
            make.height.equalTo(height/17)
        }
        passwordView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
         //   make.top.equalTo(phoneNumView.snp.bottom).offset(height/51)
            make.bottom.equalTo(signInButton.snp.top).offset(-height/11)
            make.height.equalTo(height/17)
        }
        signInButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(width/6.8)
            make.bottom.equalTo(view.snp.bottom).offset(-height/3)
         //   make.top.equalTo(passwordView.snp.bottom).offset(height/11)
        }
        forgotPasswordButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(self.passwordView.snp.bottom).offset(12)
        }
        donthaveAccountLabel.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(width/4.2)
            make.top.equalTo(signInButton.snp.bottom).offset(width/10.4)
        }
        signUpLabel.snp.makeConstraints { make in
            make.left.equalTo(donthaveAccountLabel.snp.right)
            make.centerY.equalTo(donthaveAccountLabel.snp.centerY)
            make.top.equalTo(signInButton.snp.bottom).offset(width/10.4)
        }
    
    }
    
    func moveWithKeyboard(notification : NSNotification, keyboardWillShow: Bool ) {
      
        
        if keyboardWillShow {
            signInButton.snp.makeConstraints { make in
                make.bottom.equalTo(self.view.snp.bottom).offset(-view.frame.size.height/2.8 - 10)
            }
        }else {
            for view in myViews {
                view.removeFromSuperview()
            }
            setup()
        }
       
        
        
    }
    
}


extension SignInVC {
    
    @objc func keyboardWillShow(_ sender: NSNotification) {
        guard let keyboardHeight = (sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {return}
        self.keyboardHeight = keyboardHeight.height
      //  UserDefaults.standard.set(keyboardHeight.height, forKey: "keyboardHeight")
       
        moveWithKeyboard(notification: sender, keyboardWillShow: true)
        
        if selecedIsPasswordView {
        passwordView.keyboardWillShow()
        phoneNumView.forKeyboardWillHide()
        } else {

            phoneNumView.forKeyboardWillShow()
                passwordView.keyboardWillHide()
            }
        
       
       
    }
   
    
    @objc func keyboardWillHide(_ sender: NSNotification) {
        
         moveWithKeyboard(notification: sender, keyboardWillShow: false)
        if !selecedIsPasswordView
       // selecedIsPasswordView != nil && !(selecedIsPasswordView ?? false)
        {
            passwordView.keyboardWillHide()
        }else {
            phoneNumView.forKeyboardWillHide()
        
        }

      
    }
    
    
    @objc func onTapPhoneNumView() {
        selecedIsPasswordView = false
        passwordView.keyboardWillHide()
           
    }
    
    @objc func onTapPasswordView() {
        selecedIsPasswordView = true
        phoneNumView.forKeyboardWillHide()
        

    }
    
    
    @objc func onTapBack() {
        navigationController?.viewControllers = [router.welcomeVC()]
    }
    
    @objc func tapGestureRecognizer(sender : UIGestureRecognizer) {
        guard let name = sender.name else { return }
        switch name  {
        case "view":
            passwordView.keyboardWillHide()
            phoneNumView.forKeyboardWillHide()
            view.endEditing(true)
        case "forgotPassword":
            navigationController?.viewControllers = [router.forgotPasswordVC()]
        case "signup":
            navigationController?.viewControllers = [router.signUpVC()]
        default:
            break
        }
       
    }
    
    @objc func onTapSignIn() {
        let signUpVM = SignUpVM()
        if let userNum = phoneNumView.phoneTextField.text {
            if userNum != "" {
                if !phoneNumView.checkIsNum(userNum) {
                    makeAlertForWrongCode(with: "Enter Valid Phone Number")
                } else {
                    if let userPassword = passwordView.tf.text {
                        var userValidation : [Bool] = []
                        var userIsCorrect : [Bool] = []
                        var userNot : [Bool] = []
                        vm.getUserInfo().then { result in
                            switch result {
                            case .success(let data):
                                DispatchQueue.main.async {
                                    for info in data {
                                            if info.phoneNum == "+994\(userNum)" && info.password == userPassword {
                                                userIsCorrect.append(true)
                                                
                                                break
                                            }else if info.phoneNum == "+994\(userNum)" && info.password != userPassword{
                                                userValidation.append(true)
                                            }else if info.phoneNum != "+994\(userNum)"{
                                                userNot.append(true)
                                            }
                                    }
                                    if userValidation.contains(true){
                                        self.makeAlertForWrongCode(with: "Password is not correct")
                                    }
                                    else if userNot.contains(false){
                                        self.makeAlertForWrongCode(with: "You have not an account, please sign up")
                                    }else
                                    if userIsCorrect.contains(true) {
                                        if self.vm.afterSetPassword {
                                            self.navigationController?.viewControllers = [TabBar()]
                                        } else{
                                            let num = "+994\(userNum)"
                                            signUpVM.issignUp(with: num).then({ result in
                                                switch result {
                                                case .success():
                                                    self.navigationController?.viewControllers = [self.router.verifyNumVC(num: num, userDef: true,true,false)]
                                                case .failure(let err):
                                                    self.makeAlertForWrongCode(with: err.localizedDescription)
                                                   }
                                                 })
                                               
                                             }
                                           }
                                }
                            case .failure(let err):
                                self.makeAlertForWrongCode(with: err.localizedDescription)
                            }
                        }
                    }
                }
            }
            else  {
                self.makeAlertForWrongCode(with: "Fields can not be empty")
            }
        }
    }
}
