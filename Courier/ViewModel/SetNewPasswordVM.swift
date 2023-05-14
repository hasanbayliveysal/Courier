//
//  SetNewPasswordVM.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import Foundation
import Promises
class SetNewPasswordVM {
    
    let dbService = DatabaseService()
    
    func updateUsers(model: UserModel) -> Promises.Promise<Result<Void,Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        dbService.updateUserInfo(model: model).then { res in
            promise.fulfill(res)
        }
        
        return promise
    }
    
    
}
