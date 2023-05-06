//
//  OTPView.swift
//  Courier
//
//  Created by Veysal on 4.05.2023.
//

import UIKit

class OTPView: UIView {
    
    var mainWidth : CGFloat?
    var mainHeight : CGFloat?
    var num = UserDefaults.standard.value(forKey: "number") as! String
    var otpForVerifyPassword = false
    var otpForForgotPassword = false

    // MARK: -- VARIABLES
    
    let t1 = OTPTextField()
    let t2 = OTPTextField()
    let t3 = OTPTextField()
    let t4 = OTPTextField()
    let t5 = OTPTextField()
    let t6 = OTPTextField()

    private var remainingStrStack: [String] = []
    private var timer: Timer = Timer()
    private var timerCount : Int = 120
    private var textFields = [OTPTextField]()
    private var isTyping = true
    
    
    lazy var sendCodeButton: UIButton = {
        var button = UIButton()
        addSubview(button)
        button.isEnabled = false
        button.setAttributedTitle(NSAttributedString(string: "Send code again", attributes: [.font : UIFont.systemFont(ofSize: 12, weight: .medium)]), for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
        return button
    }()
    
    private lazy var timerLabel: UILabel = {
        var label = UILabel()
        addSubview(label)
        label.textAlignment = .center
        label.text = "01 : 59"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        return label
    }()
    

    // MARK: -- FUNCTIONS
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        textFields = [t1,t2,t3,t4,t5,t6]
        createTextField()
        t1.becomeFirstResponder()
        createTimer()
        setup()
    }
    
    func createTextField() {

        var offset : CGFloat = 0
        offset = mainWidth!/27
        for textField in textFields {
            addSubview(textField)
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
                make.left.equalTo(snp.left).offset(offset)
                make.top.equalTo(snp.top).offset(20)
                make.width.height.equalTo(mainWidth!/8)
                
            }
           
            offset += (mainWidth!/8+mainWidth!/27)
        }
        t1.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
        t1.isEnabled = true
    }
    

    func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerCounter),
                                     userInfo: nil,
                                     repeats: true)
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
        sendCodeButton.isEnabled = true
        sendCodeButton.addGestureRecognizer(gestureRec)
    }
    
 
    
    func clearAllTextField() {
      
        for textField in textFields {
            textField.text = ""
            textField.layer.borderColor = UIColor.darkGray.cgColor
        }
        t1.becomeFirstResponder()
        t1.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
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
    
    func setup() {
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(t1.snp.bottom).offset(mainHeight!/33.83)
            make.right.equalTo(snp.right).offset(-16)
        }
        sendCodeButton.snp.makeConstraints { make in
            make.centerY.equalTo(timerLabel.snp.centerY)
            make.right.equalTo(timerLabel.snp.left).offset(-4)
            make.top.equalTo(t1.snp.bottom).offset(mainHeight!/33.83)
        }
        
    }
    
// MARK: -- @OBJC FUNCTIONS
    
    @objc
    func timerCounter(){
        timerCount = timerCount - 1
        let time = secondsToMinutesAndSeconds(seconds: timerCount)
        let timeString = makeStringFromInt(minutes: time.0, seconds: time.1)
        timerLabel.text = timeString
        if timerCount == 0 {
            timer.invalidate()
            timerCount = 120
            timerLabel.removeFromSuperview()
            sendCodeButton.removeFromSuperview()
            addSubview(sendCodeButton)
            sendCodeButton.snp.makeConstraints { make in
                make.right.equalTo(snp.right).offset(-16)
                make.top.equalTo(t1.snp.bottom).offset(mainHeight!/33.83)
            }
           // sendCodeButton.isEnabled = true
            sendCodeButton.setAttributedTitle(NSAttributedString(string: "Send again", attributes: [.underlineStyle : NSUnderlineStyle.single.rawValue, .font : UIFont.systemFont(ofSize: 12, weight: .medium)]), for: .normal)
            makeGesture()
        }
    }
    
    
    @objc func onTapTF(tf: OTPTextField) {
        tf.text = ""
    }
    
    
    @objc func onTapLabel() {
        clearAllTextField()
//        if otpForVerifyPassword {
//            print(num)
//            VerifyNumVM(number: num).issignUp(with: num).then { result in
//                    switch result {
//                    case .success():
//                        print("code sended again")
//                    case .failure(let err):
//                        print(err.localizedDescription)
//                    }
//                }
//        }
//      
//        if otpForForgotPassword {
//            
//        }
        
        sendCodeButton.isEnabled = false
        sendCodeButton.setAttributedTitle(NSAttributedString(string: "Send code again", attributes: [.font : UIFont.systemFont(ofSize: 12, weight: .medium)]), for: .normal)
        sendCodeButton.removeFromSuperview()
        addSubview(timerLabel)
        addSubview(sendCodeButton)
        timerLabel.text = "01 : 59"
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(t1.snp.bottom).offset(mainHeight!/33.83)
            make.right.equalTo(snp.right).offset(-16)
        }
        sendCodeButton.snp.makeConstraints { make in
            make.centerY.equalTo(timerLabel.snp.centerY)
            make.right.equalTo(timerLabel.snp.left).offset(-4)
            make.top.equalTo(t1.snp.bottom).offset(mainHeight!/33.83)
        }
        
        createTimer()
        
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
                break
            default:
                break
            }
        }
    }
    
    
    
}
