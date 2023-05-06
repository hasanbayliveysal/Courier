//
//  InformationView.swift
//  Courier
//
//  Created by Veysal on 4.05.2023.
//

import UIKit

class InformationView: UIView {
    
    var firstLabelText : String?
    var secondLabelText : String?
    var height : CGFloat?
    var width : CGFloat?
    

    

    private lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        self.addSubview(label)
        label.text = firstLabelText
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()

    private lazy var informationLabel: UILabel = {
        var label = UILabel()
        self.addSubview(label)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.alpha = 0.3
        label.text = secondLabelText
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setup()
    }
   
    func setup() {
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top)
        }
        informationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(welcomeLabel.snp.bottom).offset(height!/33.8)
        }
    }
    
    
}
