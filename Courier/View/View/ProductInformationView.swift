//
//  ProductInformationView.swift
//  Courier
//
//  Created by Veysal on 16.05.2023.
//

import UIKit

class ProductInformationView : UIView {
    
    var height: CGFloat?
    var width: CGFloat?
    var isSelectedCheckBox = false
    var selectedTf : UITextField?
    private var labelForName = UILabel()
    private var labelForWidth = UILabel()
    private var labelForHeight = UILabel()
    private var labelForLength = UILabel()
    private var labelForWeight = UILabel()
   
    private var myLabels = [UILabel]()
    lazy var productName: SDCTextField = {
        let tf = SDCTextField()
        tf.clipsToBounds = true
        tf.addPadding()
        tf.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        tf.layer.cornerRadius = 5
        tf.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        tf.layer.borderWidth = 0.2
        tf.textAlignment = .natural
        tf.tag = 0
        tf.tintColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        tf.addTarget(self, action: #selector(onTapTf), for: .editingDidBegin)
        let attributedPlaceholder = NSAttributedString(string: "Product Name", attributes: [.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25), .font : UIFont.systemFont(ofSize: 16, weight: .regular)])
        tf.attributedPlaceholder = attributedPlaceholder
        return tf
    }()
    lazy var checkBox : UIImageView = {
       let icon = UIImageView()
        icon.image = UIImage(named: "unchecked")
        return icon
    }()
    private lazy var brokenPrLbl : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Easily broken product"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        return label
    }()
    
    lazy var addAnotherBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Add another product +", for: .normal)
        button.setTitleColor(UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1), for: .normal)
        return button
    }()
    
    lazy var widthTf = SDCTextField()
    lazy var heightTf = SDCTextField()
    lazy var lengthTf = SDCTextField()
    lazy var weigthTf = SDCTextField()
    private var myTfs : [SDCTextField] = []
    private var myAllTf : [SDCTextField] = []
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        createTF()
        setup()
        createGesture()
        //createLabelforTf()
    }
    
    func forKeyboardWillShow(){
        
        if let selectedTf = selectedTf {
            createLabelforTf(selectedTf)
            selectedTf.layer.borderColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1).cgColor
            selectedTf.layer.borderWidth = 1
            
        }
    }
    
    func forkeyboardWillHide(){
        defaultTf()
    }
    
    
    func createGesture() {
        let gestureR = UITapGestureRecognizer(target: self, action: #selector(onTapCheckBox))
        checkBox.isUserInteractionEnabled = true
        checkBox.addGestureRecognizer(gestureR)
    }
    
    func createLabelforTf(_ tf : UITextField){
    
        addSubview(labelForName)

        labelForName.backgroundColor = .white
        tf.bringSubviewToFront(labelForName)
        labelForName.text = tf.placeholder
        let attributedPlaceholder = NSAttributedString(string: tf.placeholder!, attributes: [.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0), .font : UIFont.systemFont(ofSize: 16, weight: .regular)])
        tf.attributedPlaceholder = attributedPlaceholder
        labelForName.textColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        labelForName.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        labelForName.snp.makeConstraints { make in
            make.left.equalTo(tf.snp.left).offset(16)
            make.top.equalTo(tf.snp.top).offset(-6)
        }
        

    }
    
    @objc func onTapCheckBox() {
        if !isSelectedCheckBox {
            checkBox.image = UIImage(named: "checked")
            isSelectedCheckBox = true
        } else {
            checkBox.image = UIImage(named: "unchecked")
            isSelectedCheckBox = false
        }
       
    }
    
    func setup() {
       
        addSubview(productName)
        addSubview(checkBox)
        addSubview(brokenPrLbl)
        addSubview(addAnotherBtn)
        productName.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.left.equalTo(snp.left).offset(16)
            make.height.equalTo(height!/17.4)
        }
        widthTf.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(16)
            make.top.equalTo(productName.snp.bottom).offset(24)
        }
        heightTf.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(productName.snp.bottom).offset(24)
        }
        lengthTf.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(16)
            make.top.equalTo(widthTf.snp.bottom).offset(24)
        }
        weigthTf.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(heightTf.snp.bottom).offset(24)
        }
        checkBox.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(16)
            make.top.equalTo(lengthTf.snp.bottom).offset(24)
            make.width.equalTo(width!/20.8)
            make.height.equalTo(width!/20.8)
        }
        brokenPrLbl.snp.makeConstraints { make in
            make.left.equalTo(checkBox.snp.right).offset(6)
            make.centerY.equalTo(checkBox.snp.centerY)
        }
        addAnotherBtn.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(28)
            make.top.equalTo(checkBox.snp.bottom).offset(32)
        }
        
    }
    
    func createTF () {
        addArrayElements()
        var tag = 1
        for tf in myTfs {
            addSubview(tf)
            tf.layer.cornerRadius = 5
            tf.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            tf.layer.borderWidth = 0.2
            tf.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
            tf.keyboardType = .numberPad
            tf.addPadding()
            tf.tintColor = UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
            let attributedPlaceholder = NSAttributedString(string: tf.placeholder!, attributes: [.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25), .font : UIFont.systemFont(ofSize: 16, weight: .regular)])
            tf.attributedPlaceholder = attributedPlaceholder
            tf.tag = tag
            tf.addTarget(self, action: #selector(onTapTf), for: .editingDidBegin)
            tf.snp.makeConstraints { make in
                make.height.equalTo(height!/17.4)
                make.width.equalTo(height!/4.86)
            }
            tag += 1
        }
        myAllTf = myTfs
        myTfs.removeAll()
       
    }
    func addArrayElements() {
        myTfs.append(widthTf)
        myTfs.append(heightTf)
        myTfs.append(lengthTf)
        myTfs.append(weigthTf)
        widthTf.placeholder = "Width, sm"
        heightTf.placeholder = "Height, sm"
        lengthTf.placeholder = "Length, sm"
        weigthTf.placeholder = "Weigth, sm"
    }
    
    func defaultTf(){
        addArrayElements()
        myTfs.append(productName)
        for tf in myTfs {
            if tf.text == "" {
                labelForName.removeFromSuperview()
                tf.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
                let attributedPlaceholder = NSAttributedString(string: tf.placeholder!, attributes: [.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25), .font : UIFont.systemFont(ofSize: 16, weight: .regular)])
                tf.attributedPlaceholder = attributedPlaceholder
                tf.layer.borderWidth = 0.2
            }
            
        }
 
    }
    
    @objc func onTapTf(_ sender: UITextField) {
       defaultTf()
        print(sender.tag)
        switch sender.tag {
        case 0:
            selectedTf = productName
        case 1:
            selectedTf = widthTf
        case 2:
            selectedTf = heightTf
        case 3:
            selectedTf = lengthTf
        case 4:
            selectedTf = weigthTf
        default:
            break
        }
    }
    
}


