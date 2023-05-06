//
//  SetNewPasswordVC.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import UIKit

class SetNewPasswordVC: BaseVC<SetNewPasswordVM> {
    var selectedIsFirst = true
    var timer: Timer?
    var passwordIsOK = false
    
    lazy var infView: InformationView = {
        let view = InformationView()
        view.height = self.view.frame.size.height
        view.width = self.view.frame.size.width
        view.firstLabelText = "Set a new password to continue"
        view.secondLabelText = "Change your password and \nsign in"
        return view
    }()
    
    private lazy var createPasswordView: PasswordView = {
        let view = PasswordView(height: height, width: width)
        view.tfPlaceHolder = "Password"
        view.tf.addTarget(self, action: #selector(onTapFirstView), for: .allTouchEvents)
        view.forCreatePassword = true
        return view
    }()
    
    private lazy var passwordAgainView: PasswordView = {
        let view = PasswordView(height: height, width: width)
        view.tfPlaceHolder = "Password again"
        view.tf.addTarget(self, action: #selector(onTapSecondView), for: .allTouchEvents)
        view.forCreatePassword = false
        return view
    }()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "* Password must be 6 or more characters"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        label.font = UIFont.systemFont(ofSize: height/67.6, weight: .regular)
        return label
    }()
    
    private lazy var changePasswordBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Change password", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = height/203
        button.backgroundColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        button.addTarget(self, action: #selector(onTapChangePassword), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setup() {
        self.view.addSubview(infView)
        view.addSubview(createPasswordView)
        view.addSubview(passwordAgainView)
    }
    
    @objc func onTapFirstView() {
        selectedIsFirst = true
        if passwordAgainView.tf.text == "" {
            passwordAgainView.keyboardWillHide()
        }
       
    }
    
    @objc func onTapSecondView() {
        selectedIsFirst = false
        if createPasswordView.tf.text == "" {
            createPasswordView.keyboardWillHide()
        }
       
    }
    
    @objc func keyboardWillShow(_ notification : NSNotification) {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkPasswordAreSame), userInfo: nil, repeats: true)
        if selectedIsFirst {
            createPasswordView.keyboardWillShow()
        } else {
            passwordAgainView.keyboardWillShow()
        }
        moveViewWithKeyboard(notification: notification, keyboardWillShow: true)
        
    }
    
    @objc func keyboardWillHide(_ notification : NSNotification){
        timer?.invalidate()
        if selectedIsFirst {
            if createPasswordView.tf.text == "" {
                createPasswordView.keyboardWillHide()
            }
           
        } else {
            if passwordAgainView.tf.text == "" {
                passwordAgainView.keyboardWillHide()
            }
        }
        moveViewWithKeyboard(notification: notification, keyboardWillShow: false)
    }
    
    func moveViewWithKeyboard(notification: NSNotification, keyboardWillShow: Bool) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        if keyboardWillShow {
         //   infView.removeFromSuperview()
//            signUpBtn.snp.makeConstraints { make in
//                make.bottom.equalTo(view.snp.bottom).offset(-keyboardHeight-10)
//            }
        } else {
//            for variable in variables {
//                variable.removeFromSuperview()
//            }
            setup()

        }
        
    }
    
    @objc func checkPasswordAreSame() {
        if checkPassword(password: createPasswordView.tf.text!, passwordAgain: passwordAgainView.tf.text!) {
         
                if createPasswordView.tf.text!.count >= 6 {
                    infoLabel.text = "Passwords are same"
                    passwordIsOK = true
                    infoLabel.textColor = .systemGreen
                }else {
                    infoLabel.alpha = 0.6
                    infoLabel.text = "* Password must be 6 or more characters"
                    infoLabel.textColor = .black
                }
        } else {
            
            if createPasswordView.tf.text!.count < 6  {
                infoLabel.alpha = 0.6
                infoLabel.text = "* Password must be 6 or more characters"
                infoLabel.textColor = .black
            }else {
                infoLabel.alpha = 1
                infoLabel.text = "Passwords are not same"
                infoLabel.textColor = .red
            }
        }
    }

    
    @objc func onTapChangePassword() {
        if passwordIsOK {
            self.makeAlertForWrongCode(with: "Password changed succsesfully, you can login")
            navigationController?.viewControllers = [router.signInVC()]
        }
        
    }

}
