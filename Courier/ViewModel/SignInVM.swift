//
//  SignInVM.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import Promises

class SignInVM {
    let service = DatabaseService()
    var afterSetPassword: Bool
    
    init(afterSetPassword: Bool) {
        self.afterSetPassword = afterSetPassword
    }
    
    func getUserInfo()  -> Promise<Result<[UserModel],Error>> {
        let promise = Promise<Result<[UserModel],Error>>.pending()
        service.getUsersInfo().then { result in
            promise.fulfill(result)
        }
        
        return promise
    }
    
}
