//
//  MoreVM.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import Foundation
import Promises
class MoreVM {
    
    private let authService = AuthService()
    
    func logOut() -> Promises.Promise<Result<Void,Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        authService.logOut().then { res in
            promise.fulfill(res)
        }
        return promise
    }
    
}
