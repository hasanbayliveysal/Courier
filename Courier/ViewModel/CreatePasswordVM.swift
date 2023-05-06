//
//  CreatePasswordVM.swift
//  Courier
//
//  Created by Veysal on 3.05.2023.
//

import Foundation
import Promises

class CreatePasswordVM {
    var service = DatabaseService()
    var userInfo : [UserModel] = []
    
    func saveUser(with model: UserModel) -> Promise<Result<Void,Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        service.saveUsersInfo(with: model).then { result in
            promise.fulfill(result)
        }
        return promise
        
    }
    
    
    
}
