//
//  ViewController.swift
//  Courier
//
//  Created by Veysal on 30.04.2023.
//

import UIKit
import SnapKit


class WelcomeVC: BaseVC<WelcomeVM> {
    
    //MARK: -- VARIABLES
    
    
   
    
    private lazy var logoLabel: UILabel = {
        var label = UILabel()
        view.addSubview(label)
        label.text = "Courier"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        return label
    }()
    
    private lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        view.addSubview(label)
        label.text = "Welcome to Courier Delivery!"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()

    private lazy var informationLabel: UILabel = {
        var label = UILabel()
        view.addSubview(label)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.alpha = 0.3
        label.text = "Sign up and get start delivery your \nluggage!"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private lazy var signInBtn: UIButton = {
        let button = UIButton()
        view.addSubview(button)
        button.backgroundColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        button.setTitle("Sign In", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        return button
    }()
    
    private lazy var signUpBtn: UIButton = {
        let button = UIButton()
        view.addSubview(button)
        button.setTitle("Sign Up", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.setTitleColor(UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1), for: .normal)
        button.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(onTapSignUp), for: .touchUpInside)
        return button
    }()
    
    private lazy var languageView: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.alpha = 0.01
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        view.addSubview(label)
        label.text = "English             ▼"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    
    //MARK: -- FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        addGestureRecognizer()
   

    }


    
    func setup() {
        logoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoLabel.snp.bottom).offset(height/10.15)
        }
        informationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(welcomeLabel.snp.bottom).offset(height/33.8)
        }
        signInBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(informationLabel.snp.bottom).offset(height/16.9)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.height.equalTo(width/6.8)
        }
        signUpBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signInBtn.snp.bottom).offset(height/101.5)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.height.equalTo(width/6.8)
        }
        languageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpBtn.snp.bottom).offset(height/3.36)
            make.width.equalTo(height/5.1)
            make.height.equalTo(width/9.4)
        }
        languageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(languageView.snp.centerX)
            make.centerY.equalTo(languageView.snp.centerY)
        }
    }
    
    
    func addGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapLanguageView))
        languageLabel.isUserInteractionEnabled = true
        languageLabel.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc
    func onTapLanguageView() {
        print("it is ok")
    }
    
    @objc
    func onTapSignUp() {
        navigationController?.viewControllers = [router.signUpVC()]
    }
}
