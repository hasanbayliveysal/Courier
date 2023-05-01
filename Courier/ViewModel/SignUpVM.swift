//
//  SignUpVM.swift
//  Courier
//
//  Created by Veysal on 1.05.2023.
//


import Promises

class SignUpVM {
    var number: String = ""
    let service = AuthService()
    
    func issignUp(with number: String) -> Promise<Result<Void,Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        service.signUp(with: number).then { result in
            promise.fulfill(result)
        }
        return promise
    }
    
}
