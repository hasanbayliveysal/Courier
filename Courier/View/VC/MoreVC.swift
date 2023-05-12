//
//  MoreVC.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import UIKit

class MoreVC: BaseVC<MoreVM> {
    
    var timerCounting:Bool = true
    var startTime = 120
    var stopTime : Int?
    
    
    let userDefaults = UserDefaults.standard
    let START_TIME_KEY = "startTime"
    let STOP_TIME_KEY = "stopTime"
    let COUNTING_KEY = "countingKey"
    var scheduledTimer: Timer!
    
    private lazy var timeLabel: UILabel = {
       let label = UILabel()
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 36, weight: .regular)
        label.text = "01:59"
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .white
        setStartTime(time: startTime)
        setTimerCounting(true)
        
        startTime = userDefaults.object(forKey: START_TIME_KEY) as! Int
        stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Int
        timerCounting = userDefaults.bool(forKey: COUNTING_KEY)
        
        
        if timerCounting {
            scheduledTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
           // startTimer()
        }else {
            stopTimer()
        }
        
    }
    func setup() {
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
//    func startTimer()
//    {
//        scheduledTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
//        setTimerCounting(true)
//    }
    func stopTimer(){
        
    }
    
    @objc func refreshValue() {
    
            startTime = startTime - 1
            let time = secondsToMinutesAndSeconds(seconds: startTime)
            let timeString = makeStringFromInt(minutes: time.0, seconds: time.1)
            timeLabel.text = timeString
        if startTime == 0 {
            scheduledTimer.invalidate()
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
    
    
    
    func setStartTime(time: Int)
    {
        startTime = time
        userDefaults.set(startTime, forKey: START_TIME_KEY)
    }
    
    func setStopTime(time: Int?)
    {
        stopTime = time
        userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
    }
    
    func setTimerCounting(_ val: Bool)
    {
        timerCounting = val
        userDefaults.set(timerCounting, forKey: COUNTING_KEY)
    }


}

