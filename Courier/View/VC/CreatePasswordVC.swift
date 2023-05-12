//
//  CreatePasswordVC.swift
//  Courier
//
//  Created by Veysal on 3.05.2023.
//

import UIKit

class CreatePasswordVC: BaseVC<CreatePasswordVM> {
    
    //MARK: -- VARIABLES
    
    var isChecked = false
    var selectedIsFirst = true
    var timer : Timer?
    var passwordIsOK = false
    
    var variables : [AnyObject] = []
  
    private lazy var infView: InformationView = {
        var view  = InformationView()
        view.firstLabelText = "Welcome to Courier!"
        view.secondLabelText = "Sign up and start to delivery your \nluggage! "
        view.height = height
        view.width = width
        return view
    }()
    
    private lazy var createPasswordView: PasswordView = {
        let view = PasswordView()
        view.width = width
        view.height = height
        view.tfPlaceHolder = "Password"
        view.tf.addTarget(self, action: #selector(onTapFirstView), for: .allTouchEvents)
        view.forCreatePassword = true
        return view
    }()
    
    private lazy var passwordAgainView: PasswordView = {
        let view = PasswordView()
        view.width = width
        view.height = height
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
    
    private lazy var agreeLabel: UILabel = {
        let label = UILabel()
        label.text = "I agree to the "
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        label.font = UIFont.systemFont(ofSize: height/50.75, weight: .regular)
        return label
    }()
    
    private lazy var checkBox : UIImageView = {
       let icon = UIImageView()
        icon.image = UIImage(named: "unchecked")
        return icon
    }()
    
    private lazy var termsAndConditionLabel: UILabel = {
        let label = UILabel()
        label.text = "Terms and Conditions"
        label.textColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        label.font = UIFont.systemFont(ofSize: height/50.75, weight: .regular)
        return label
    }()
    
    private lazy var signUpBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = height/203
        button.backgroundColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        button.addTarget(self, action: #selector(onTapSignUp), for: .touchUpInside)
        return button
    }()
    
    private lazy var haveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have account? "
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        label.font = UIFont.systemFont(ofSize: height/67.6, weight: .regular)
        return label
    }()
    
    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in"
        label.textColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        label.font = UIFont.systemFont(ofSize: height/60, weight: .regular)
        return label
    }()
    
    
    //MARK: -- FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Courier"
        appendVariables()
        setup()
        makeGesture()
        getUsers()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(onTapBack))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func getUsers() {
     //   let mydata : [UserModel] = []
 
    }
    
    func appendVariables() {
        variables.append(infView)
        variables.append(createPasswordView)
        variables.append(passwordAgainView)
        variables.append(infoLabel)
        variables.append(checkBox)
        variables.append(agreeLabel)
        variables.append(termsAndConditionLabel)
        variables.append(signUpBtn)
        variables.append(haveAccountLabel)
        variables.append(signInLabel)
    }

    
    func makeGesture() {
        
        let gestureForHomeView = UITapGestureRecognizer(target: self, action: #selector(onTapCheckBox))
        gestureForHomeView.name = "home"
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gestureForHomeView)
        
        let gestureRecForCheckBox = UITapGestureRecognizer(target: self, action: #selector(onTapCheckBox))
        gestureRecForCheckBox.name = "checkbox"
        checkBox.isUserInteractionEnabled = true
        checkBox.addGestureRecognizer(gestureRecForCheckBox)
        
        let gestureRecForTermsAndConditions = UITapGestureRecognizer(target: self, action: #selector(onTapCheckBox))
        gestureRecForTermsAndConditions.name = "terms"
        termsAndConditionLabel.isUserInteractionEnabled = true
        termsAndConditionLabel.addGestureRecognizer(gestureRecForTermsAndConditions)
        
        let gestureForSignIn = UITapGestureRecognizer(target: self, action: #selector(onTapCheckBox))
        gestureForSignIn.name = "signin"
        signInLabel.isUserInteractionEnabled = true
        signInLabel.addGestureRecognizer(gestureForSignIn)
        
    }
    
   
    func moveViewWithKeyboard(notification: NSNotification, keyboardWillShow: Bool) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        if keyboardWillShow {
         //   infView.removeFromSuperview()
            signUpBtn.snp.makeConstraints { make in
                make.bottom.equalTo(view.snp.bottom).offset(-keyboardHeight-10)
            }
        } else {
            for variable in variables {
                variable.removeFromSuperview()
            }
            setup()

        }
        
    }
    


    func setup() {
        for variable in variables {
            view.addSubview(variable as! UIView)
        }
        signUpBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-height/3.44)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.height.equalTo(width/6.8)
        }
        infView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(createPasswordView.snp.top).offset(-height/25)
            make.width.equalTo(width)
            make.height.equalTo(height/8.93)
        }
        createPasswordView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(signUpBtn.snp.top).offset(-height/4.4)
            make.height.equalTo(height/17)
        }
        passwordAgainView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(createPasswordView.snp.bottom).offset(height/51)
            make.height.equalTo(height/17)
        }
        infoLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(passwordAgainView.snp.bottom).offset(8)
        }
        checkBox.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(infoLabel.snp.top).offset(width/9)
            make.width.equalTo(width/20.8)
            make.height.equalTo(width/20.8)
        }
        agreeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkBox.snp.centerY)
            make.left.equalTo(checkBox.snp.right).offset(10)
        }
        termsAndConditionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkBox.snp.centerY)
            make.left.equalTo(agreeLabel.snp.right)
        }

        haveAccountLabel.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(width/4.2)
            make.top.equalTo(signUpBtn.snp.bottom).offset(width/10.4)
        }
        signInLabel.snp.makeConstraints { make in
            make.left.equalTo(haveAccountLabel.snp.right)
            make.centerY.equalTo(haveAccountLabel.snp.centerY)
            make.top.equalTo(signUpBtn.snp.bottom).offset(width/10.4)
        }

    }

    
    @objc func onTapCheckBox(sender: UITapGestureRecognizer) {
        guard let name = sender.name else {return}
        switch name {
        case "home":
            view.endEditing(true)
        case "checkbox":
            if !isChecked {
                isChecked = true
                checkBox.image = UIImage(named: "checked")
            } else {
                isChecked = false
                checkBox.image = UIImage(named: "unchecked")
            }
        case "terms":
            let vc = TermsAndConditionsVC()
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true)
     
        case "signin":
            navigationController?.viewControllers = [router.signInVC(afterSetPassword: false)]
        default:
            break
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
                    passwordIsOK = false
                    infoLabel.text = "* Password must be 6 or more characters"
                    infoLabel.textColor = .black
                }
        } else {
            
            if createPasswordView.tf.text!.count < 6  {
                passwordIsOK = false
                infoLabel.alpha = 0.6
                infoLabel.text = "* Password must be 6 or more characters"
                infoLabel.textColor = .black
            }else {
                infoLabel.alpha = 1
                passwordIsOK = false
                infoLabel.text = "Passwords are not same"
                infoLabel.textColor = .red
            }
        }
    }
//
    
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
        
                createPasswordView.keyboardWillHide()
        
           
        } else {
           
                passwordAgainView.keyboardWillHide()
            
        }
        moveViewWithKeyboard(notification: notification, keyboardWillShow: false)
    }
    
    // MARK: -- NAVIGATIONS
    
    @objc func onTapSignUp() {
        
        let number = UserDefaults.standard.object(forKey: "number") as! String
        if passwordIsOK && isChecked {
            let model = UserModel(phoneNum: number, password: passwordAgainView.tf.text!)
            vm.saveUser(with: model).then { result in
                switch result {
                case .success():
                    self.navigationController?.viewControllers = [self.router.signInVC(afterSetPassword: true)]
                case .failure(let err):
                    self.makeAlertForWrongCode(with: err.localizedDescription)
                }
            }
        } else if passwordIsOK && !isChecked {
            self.makeAlertForWrongCode(with: "You have to agree with Terms and Conditions")
        } else {
            self.makeAlertForWrongCode(with: "Check passwords are correct")
        }

        
    }
    
    @objc func onTapBack () {
        navigationController?.viewControllers = [router.signUpVC()]
    }

}

extension UIViewController {
    
    
    func checkPassword (password: String , passwordAgain: String) -> Bool {
        return password == passwordAgain
    }
//
}
