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
    var myViews : [AnyObject] = []
    
    lazy var infView: InformationView = {
        let view = InformationView()
        view.height = self.view.frame.size.height
        view.width = self.view.frame.size.width
        view.firstLabelText = "Set a new password to continue"
        view.secondLabelText = "Change your password and \nsign in"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var createPasswordView: PasswordView = {
        let view = PasswordView()
        view.width = width
        view.height = height
        view.tfPlaceHolder = "Password"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tf.addTarget(self, action: #selector(onTapFirstView), for: .allTouchEvents)
        view.forCreatePassword = true
        return view
    }()
    
    private lazy var passwordAgainView: PasswordView = {
        let view = PasswordView()
        view.width = width
        view.height = height
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tfPlaceHolder = "Password again"
        view.tf.addTarget(self, action: #selector(onTapSecondView), for: .allTouchEvents)
        view.forCreatePassword = false
        return view
    }()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "* Password must be 6 or more characters"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        label.font = UIFont.systemFont(ofSize: height/67.6, weight: .regular)
        return label
    }()
    
    private lazy var changePasswordBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Change password", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = height/203
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        button.addTarget(self, action: #selector(onTapChangePassword), for: .touchUpInside)
        return button
    }()
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Courier"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(onTapBack))
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        myViews.append(infView)
        myViews.append(createPasswordView)
        myViews.append(passwordAgainView)
        myViews.append(changePasswordBtn)
        
        createScrollView()
        setup()
    }
    func createScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.backgroundColor = .cyan
       // scrollView.isScrollEnabled = true
       // contentView.backgroundColor = .red
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.isScrollEnabled = false
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(height/5.4)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
           // make.height.equalTo(height/2)
            make.left.right.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.top.equalTo(scrollView.snp.top)
            make.height.equalTo(view.frame.size.height)
            make.width.equalTo(view.frame.size.width)
        }
        
    }
    
    func setup() {
       
        for view in myViews {
            self.contentView.addSubview(view as! UIView)
        }

        passwordAgainView.keyboardWillHide()
        createPasswordView.keyboardWillHide()   
        changePasswordBtn.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(passwordAgainView.snp.bottom).offset(height/12)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-16)
            make.height.equalTo(width/6.8)
        }
        infView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top)//.offset(height/5.43)
            make.width.equalTo(width)
            make.height.equalTo(height/5)
        }
        createPasswordView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-16)
            make.top.equalTo(infView.snp.bottom)//.offset(height/12.6)
            make.height.equalTo(height/17)
        }
        passwordAgainView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-16)
            make.top.equalTo(createPasswordView.snp.bottom).offset(height/51)
            make.height.equalTo(height/17)
        }
    }
    
    @objc func onTapFirstView() {
        print("first")
        selectedIsFirst = true
        if passwordAgainView.tf.text == "" {
            passwordAgainView.keyboardWillHide()
        }
       
    }
    
    @objc func onTapSecondView() {
        print("second")
        selectedIsFirst = false
        if createPasswordView.tf.text == "" {
            createPasswordView.keyboardWillHide()
        }
       
    }
    
    @objc func keyboardWillShow(_ notification : NSNotification) {
        scrollView.isScrollEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkPasswordAreSame), userInfo: nil, repeats: true)
        if selectedIsFirst {
            createPasswordView.keyboardWillShow()
        } else {
            passwordAgainView.keyboardWillShow()
        }
        moveViewWithKeyboard(notification: notification, keyboardWillShow: true)
        
    }
    
    @objc func keyboardWillHide(_ notification : NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.isScrollEnabled = false
      
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
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//        let keyboardHeight = keyboardSize.height
//        if keyboardWillShow {
//            changePasswordBtn.snp.makeConstraints { make in
//                make.bottom.equalTo(view.snp.bottom).offset(-keyboardHeight-10)
//            }
//        } else {
//
//            for view in myViews {
//                    view.removeFromSuperview()
//                }
//            setup()
//            }
////            for view in myViews {
////                view.removeFromSuperview()
////            }
////
//
//
//
//        if keyboardWillShow {
//            guard let userInfo = notification.userInfo else { return }
//            var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
//            keyboardFrame = self.view.convert(keyboardFrame, from: nil)
//
//            var contentInset:UIEdgeInsets = self.scrollView.contentInset
//            contentInset.bottom = keyboardFrame.size.height
//            scrollView.contentInset = contentInset
//        } else {
//            let contentInset:UIEdgeInsets = UIEdgeInsets.zero
//                scrollView.contentInset = contentInset
//        }
//
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
            navigationController?.viewControllers = [router.signInVC(afterSetPassword: false)]
        }
        
    }

    @objc func onTapBack() {
        navigationController?.viewControllers = [router.forgotPasswordVC()]
    }
    
}
