//
//  VerifyNumVC.swift
//  Courier
//
//  Created by Veysal on 1.05.2023.
//

import UIKit




class VerifyNumVC: BaseVC<VerifyNumVM> {
    
    //MARK: -- VARIABLES

    
    let t1 = OTPTextField()
    let t2 = OTPTextField()
    let t3 = OTPTextField()
    let t4 = OTPTextField()
    let t5 = OTPTextField()
    let t6 = OTPTextField()

    var remainingStrStack: [String] = []

    
    var timer: Timer = Timer()
    var count : Int = 120
    var textFields = [OTPTextField]()
    
    var isTyping = true

    private lazy var informationLabel: UILabel = {
        var label = UILabel()
        view.addSubview(label)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Enter the 6-digit code sent to your \nphone number."
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private lazy var sendCodeLabel: UILabel = {
        var label = UILabel()
        view.addSubview(label)
        label.textAlignment = .right
        label.text = "Send code again"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        var label = UILabel()
        view.addSubview(label)
        label.textAlignment = .center
        label.text = "01 : 59"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        return label
    }()
    

    
    
    
    //MARK: -- FUNCTIONS

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Courier"
        view.backgroundColor = .white
        setup()
        createTimer()
        createGesture()
       
       // autoFillTextField(with: "1347")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(onTapBack))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTextField()
        t1.becomeFirstResponder()
    }
    
    func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerCounter),
                                     userInfo: nil,
                                     repeats: true)
    }
    

    
    func setup() {
        informationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(height/4.5)
        }
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(height/2.34)
            make.right.equalTo(view.snp.right).offset(-16)
        }
        sendCodeLabel.snp.makeConstraints { make in
            make.right.equalTo(timerLabel.snp.left).offset(-4)
            make.top.equalTo(view.snp.top).offset(height/2.34)
        }
        
        
        
    }
    
    
    @objc
    func onTapBack () {
        navigationController?.viewControllers = [router.signUpVC()]
    }
    
    @objc
    func timerCounter() -> Void {
        count = count - 1
        let time = secondsToMinutesAndSeconds(seconds: count)
        let timeString = makeStringFromInt(minutes: time.0, seconds: time.1)
        timerLabel.text = timeString
        if count == 0 {
            timer.invalidate()
            count = 120
            timerLabel.removeFromSuperview()
            sendCodeLabel.removeFromSuperview()
            self.view.addSubview(sendCodeLabel)
            sendCodeLabel.snp.makeConstraints { make in
                make.right.equalTo(view.snp.right).offset(-16)
                make.top.equalTo(view.snp.top).offset(height/2.34)
            }
            sendCodeLabel.attributedText = NSAttributedString(string: "Send again", attributes: [.underlineStyle : NSUnderlineStyle.single.rawValue])
            makeGesture()
        }
    }
    
    func secondsToMinutesAndSeconds (seconds: Int) -> (Int, Int) {
        return (seconds/60, seconds%60)
    }
    
    func makeStringFromInt(minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "0%d", minutes)
        timeString += " : "
        if seconds >= 10 {
            timeString += String(format: "%d", seconds)
        } else {
            timeString += String(format: "0%d", seconds)
        }
       
        
        return timeString
    }
    
    func makeGesture() {
   
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(onTapLabel))
        sendCodeLabel.isUserInteractionEnabled = true
        sendCodeLabel.addGestureRecognizer(gestureRec)
    }
    

    func createTextField() {
        
        textFields = [t1,t2,t3,t4,t5,t6]
        var offset : CGFloat = 0
        offset = width/27
        for textField in textFields {

            view.addSubview(textField)
            textField.delegate = self
            textField.textColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
            textField.isEnabled = false
            textField.font = UIFont.systemFont(ofSize: 24, weight: .medium)
            textField.addTarget(self, action: #selector(self.textDidChange(textField: )), for: .editingChanged)
            textField.addTarget(self, action: #selector(onTapTF), for: .allTouchEvents)
            textField.tintColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 0)
            textField.backgroundColor = .white
            textField.layer.borderColor = UIColor.darkGray.cgColor
            textField.layer.borderWidth = 3
            textField.layer.cornerRadius = 10
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
          
            textField.snp.makeConstraints { make in
                make.left.equalTo(view.snp.left).offset(offset)
                make.top.equalTo(informationLabel.snp.bottom).offset(width/5.8)
                make.width.height.equalTo(width/8)
                
            }
            print(offset)
            offset += (width/8+width/27)
            
            
        }
        t1.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
        t1.isEnabled = true
       
        
    }
    
    func clearAllTextField() {
        
        for textField in textFields {
            textField.text = ""
            textField.layer.borderColor = UIColor.darkGray.cgColor
        }
        t1.becomeFirstResponder()
        t1.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
        
    }
    
 
    @objc func onTapTF(tf: OTPTextField) {
        tf.text = ""
    }
    
    
    @objc func textDidChange(textField: OTPTextField) {
        t1.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
        
        t6.previousTextField = t5
        t5.previousTextField = t4
        t4.previousTextField = t3
        t3.previousTextField = t2
        t2.previousTextField = t1
        
        t5.nextTextField = t6
        t4.nextTextField = t5
        t3.nextTextField = t4
        t2.nextTextField = t3
        t1.nextTextField = t2

        let text = textField.text
        autoFillTextField(with: text!,field: textField)
        if (text?.utf8.count)! >= 1 {

            switch textField {
            case t1:
                t2.isEnabled = true
                t2.becomeFirstResponder()
                t2.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
             
                break
            case t2:
                t3.isEnabled = true
                t3.becomeFirstResponder()
                t3.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
              
                break
            case t3:
                t4.isEnabled = true
                t4.becomeFirstResponder()
                t4.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
               
                break
            case t4:
                t5.isEnabled = true
                t5.becomeFirstResponder()
                t5.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
            
                break
            case t5:
                t6.isEnabled = true
                t6.becomeFirstResponder()
                t6.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
              
                break
            case t6:
                t6.resignFirstResponder()
                
                print(getOTP())
                vm.verifyCode(with: getOTP()).then { result in
                    switch result {
                    case .success():
                        DispatchQueue.main.async {
                            self.navigationController?.viewControllers = [self.router.createPasswordVC()]
                        }
                    case .failure(let err):
                        print("error is \(err.localizedDescription)")
                    }
                }
                
                print(getOTP())
                break
            default:
                break
            }
        }
    }
    
    
    @objc func onTapLabel() {
        clearAllTextField()
        
        vm.issignUp(with: self.vm.number).then { result in
                print(self.vm.number)
                switch result {
                case .success():
                    print("code sended again")
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }

       
        sendCodeLabel.isUserInteractionEnabled = false
        sendCodeLabel.attributedText = NSAttributedString(string: "Send code again")
        sendCodeLabel.removeFromSuperview()
        view.addSubview(timerLabel)
        view.addSubview(sendCodeLabel)
        timerLabel.text = "01 : 59"
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(height/2.34)
            make.right.equalTo(view.snp.right).offset(-16)
        }
        sendCodeLabel.snp.makeConstraints { make in
            make.right.equalTo(timerLabel.snp.left).offset(-4)
            make.top.equalTo(view.snp.top).offset(height/2.34)
        }
        
        createTimer()
        
        
        
    }
    
    func createGesture() {
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(onTapMainView))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gestureRec)
       
    }
    
    @objc func onTapMainView() {
        view.endEditing(true)
    }
    
  func autoFillTextField(with string: String, field : OTPTextField) {
      remainingStrStack = string.reversed().compactMap{String($0)}
          
               if let charToAdd = remainingStrStack.popLast() {
                   field.text = String(charToAdd)
                   field.nextTextField?.text = remainingStrStack.first
                  if let nextField = field.nextTextField {
                      nextField.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
                       guard let next = field.nextTextField else {return}
                      if nextField.text != "" {
                          next.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
                      }
                  }
           }
           remainingStrStack = []
       }
    
    final func getOTP() -> String {
           var OTP = ""
           for textField in textFields {
               OTP += textField.text ?? ""
           }
           return OTP
       }
    
    
}


extension VerifyNumVC: UITextFieldDelegate {
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//
//        if let otpTextField = textField as? OTPTextField {
//            return otpTextField.initalizeUI(forFieldType: .underlined)
//        }
//
//
//        return false
//    }
//
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if let otpTextField = textField as? OTPTextField {
//            return otpTextField.initalizeUI(forFieldType: .underlined)
//        }
//        return false
//    }
}
