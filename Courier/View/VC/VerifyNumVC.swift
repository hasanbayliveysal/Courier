//
//  VerifyNumVC.swift
//  Courier
//
//  Created by Veysal on 1.05.2023.
//

import UIKit



class VerifyNumVC: BaseVC<VerifyNumVM> {
    
    //MARK: -- VARIABLES


    var timer: Timer = Timer()
    var count : Int = 120

    
    
    private lazy var informationLabel: UILabel = {
        var label = UILabel()
        view.addSubview(label)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Enter the 4-digit code sent to your \nphone number."
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
        
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(onTapBack))
        
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
        
      //  vm.verifyCode(with: )
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(onTapLabel))
        sendCodeLabel.isUserInteractionEnabled = true
        sendCodeLabel.addGestureRecognizer(gestureRec)
    }
    
//    func getNum(num: String){
//        
//        print(num)
//      
//    }

    
    @objc func onTapLabel() {
        
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
}
