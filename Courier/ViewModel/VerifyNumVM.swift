//
//  VerifyNumVM.swift
//  Courier
//
//  Created by Veysal on 1.05.2023.
//

import Foundation
import Promises

class VerifyNumVM {
    var smsCode: String = ""
    var number: String
    var userDef: Bool
    var forSignIn: Bool
    var forNewPassword: Bool
    let service = AuthService()
    
    init(number: String, userDef: Bool,forSignIn: Bool,forNewPassword:Bool) {
        self.number = number
        self.userDef = userDef
        self.forSignIn = forSignIn
        self.forNewPassword = forNewPassword
    }
    
    func verifyCode(with smsCode: String) -> Promise<Result<Void,Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        service.verifyCode(with: smsCode).then { result in
            promise.fulfill(result)
        }
        return promise
    }
    
    func issignUp(with number: String) -> Promise<Result<Void,Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        service.signUp(with: number).then { result in
            promise.fulfill(result)
        }
        return promise
    }
}
