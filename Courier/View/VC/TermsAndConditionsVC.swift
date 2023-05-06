//
//  TermsAndConditionsVC.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import UIKit
import FirebaseFirestore

class TermsAndConditionsVC: UIViewController {
    
    let firestoreDB = Firestore.firestore()
    var terms: String?
    private lazy var infView : InformationView = {
        let view = InformationView()
        self.view.addSubview(view)
        view.height = self.view.frame.size.height
        view.width = self.view.frame.size.width
        view.secondLabelText = NSLocalizedString("terms", comment: "Lest do it")
        return view
    }()
    
    private lazy var termsAndCond : UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.text = NSLocalizedString("terms", comment: "Terms and Conditions")
        textView.sizeToFit()
        textView.isScrollEnabled = true
        textView.textColor = .black
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: self.view.frame.size.height/33.8, weight: .medium),
            .foregroundColor : UIColor(red: 0.875, green: 0.365, blue: 0.227, alpha: 1)
        ]

        self.title = "Terms and Conditions"
        view.backgroundColor = .white
        setup()
       
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        view.addSubview(termsAndCond)
        termsAndCond.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(view.frame.size.width)
            make.top.equalToSuperview().offset(50)
        }
    }
    
//    func getDocuments() {
//        firestoreDB.collection("TermsAndConditions").getDocuments { querySnapshot, error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                for document in querySnapshot!.documents {
//                    let data = document.data()
//                    self.terms = data["terms"] as? String
//                   // self.termsAndCond.text = self.terms
//                    print(data["terms"]!)
//
//                  //  print("\(document.data())")
//                }
//            }
//        }
//    }
//


}
