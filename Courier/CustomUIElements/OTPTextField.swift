//
//  OTPTextField.swift
//  Courier
//
//  Created by Veysal on 2.05.2023.
//

import Foundation
import UIKit

enum BackgroudTypes {
    case underlined
    case circle
    case diamond
    case regular
}

@objc class OTPTextField: UITextField {
    
    // Border color info for field
    var otpBorderColor : UIColor = UIColor.red
      
    // Border width info for field
      public var otpBorderWidth: CGFloat = 2
      
      public var shapeLayer: CAShapeLayer!
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
       
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    public func initalizeUI(forFieldType type: BackgroudTypes) -> Bool {
        
        
        print("you are here")
        switch type {
        case .circle :
            layer.cornerRadius = 20
            return true
        case .regular :
            layer.cornerRadius = 8
            return true
        case .diamond :
            addDiamond()
            return true
        case .underlined :
            addBottomView()
            textColor = .darkGray
            return true
        }
    }
    
    fileprivate func addDiamond() {
        let path = UIBezierPath()
              path.move(to: CGPoint(x: 30, y: 0))
              path.addLine(to: CGPoint(x: 60, y: 30))
              path.addLine(to: CGPoint(x: 30, y: 60))
              path.addLine(to: CGPoint(x: 0, y: 30))
              path.close()
              
              let maskLayer = CAShapeLayer()
              maskLayer.path = path.cgPath
              
              layer.mask = maskLayer
              
              shapeLayer = CAShapeLayer()
              shapeLayer.path = path.cgPath
              shapeLayer.lineWidth = 10
              shapeLayer.fillColor = UIColor.white.cgColor
              shapeLayer.strokeColor = otpBorderColor.cgColor
              shapeLayer.borderColor = UIColor.orange.cgColor
              
              layer.addSublayer(shapeLayer)
    }
    
    fileprivate func addBottomView() {
        let path = UIBezierPath()
                path.move(to: CGPoint(x: 0, y: 40))
                path.addLine(to: CGPoint(x:45, y: 40))
                path.close()
                
                shapeLayer = CAShapeLayer()
                shapeLayer.path = path.cgPath
                shapeLayer.lineWidth = otpBorderWidth
                shapeLayer.fillColor = backgroundColor?.cgColor
        shapeLayer.strokeColor = otpBorderColor.cgColor
                
                layer.addSublayer(shapeLayer)
    }
    
    
    var backgroudTypes : BackgroudTypes = BackgroudTypes.regular
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    
    var textFields = [OTPTextField]()
    

    override public func deleteBackward(){
        
        nextTextField?.layer.borderColor = UIColor.darkGray.cgColor
        nextTextField?.isEnabled = false
    //    nextTextField?.otpBorderColor = UIColor.darkGray2
        text = ""
        previousTextField?.becomeFirstResponder()
        
    }
    
    
    
}
