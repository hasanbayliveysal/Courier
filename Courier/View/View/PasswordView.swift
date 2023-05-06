//
//  PasswordView.swift
//  Courier
//
//  Created by Veysal on 4.05.2023.
//

import UIKit

class PasswordView: UIView {
    
    var height : CGFloat?
    var width : CGFloat?
    var iconClick = true
    var tfPlaceHolder : String?
    var forCreatePassword = true
    
    init(height: CGFloat? = nil, width: CGFloat? = nil) {
        self.height = height
        self.width = width
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainView: UIView = {
        let view = UIView()
        addSubview(view)
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        return view
    }()
    
    
    lazy var tf: SDCTextField = {
        let tf = SDCTextField()
        tf.attributedPlaceholder = NSAttributedString(string: tfPlaceHolder!, attributes: [.font : UIFont.systemFont(ofSize: 16, weight: .regular), .foregroundColor : UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)])
        tf.isSecureTextEntry = true
        tf.maxLength = 16
        tf.autocorrectionType = .no
        tf.textColor = .black
        return tf
    }()

    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .white
        return label
    }()
    
    lazy var iconEye: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "icon_visible")
        return icon
    }()
    
    

    override func draw(_ rect: CGRect) {
            super.draw(rect)
        tf.delegate = self
        setup()
        makeGesture()
    }
    
    
    func keyboardWillShow() {
        if !forCreatePassword {
            passwordLabel.text = "Password again"
        }
        tf.placeholder = ""
        tf.tintColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)//.cgColor
        mainView.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
        addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mainView.snp.top)
            make.left.equalTo(mainView.snp.left).offset(width!/16)
        }
    }
    
    func keyboardWillHide() {
        if forCreatePassword {
            tf.placeholder = "Password"
            mainView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
            passwordLabel.removeFromSuperview()
        }
        else {
            tf.placeholder = "Password again"
            mainView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
            passwordLabel.removeFromSuperview()
        }

    }
    
    func makeGesture() {
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(onTapEye))
        iconEye.isUserInteractionEnabled = true
        iconEye.addGestureRecognizer(gestureRec)
    }
    
    @objc func  onTapEye () {
        if iconClick {
            iconEye.image = UIImage(named: "icon_hide")
            tf.isSecureTextEntry = false
            iconClick = false
        } else {
            iconEye.image = UIImage(named: "icon_visible")
            tf.isSecureTextEntry = true
            iconClick = true
        }
       
        
    }
  
    func setup() {

        addSubview(mainView)
        mainView.addSubview(tf)
        mainView.addSubview(iconEye)
        
        mainView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        iconEye.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-width!/25)
            make.centerY.equalToSuperview()
            make.width.equalTo(width!/17.2)
            make.height.equalTo(width!/23.6)
        
        }
        tf.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(width!/16.3)
            make.right.equalTo(iconEye.snp.left).offset(-10)
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
