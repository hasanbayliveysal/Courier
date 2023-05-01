//
//  AuthService.swift
//  Courier
//
//  Created by Veysal on 1.05.2023.
//

import Foundation
import Promises
import FirebaseAuth

protocol AuthServiceProtocol {
    func signUp(with number: String) -> Promise<Result<Void,Error>>
    func verifyCode(with smsCode: String) -> Promise<Result<Void,Error>>
}

enum customError : Error {
    case someError
}

class AuthService: AuthServiceProtocol {
    
    private let auth = Auth.auth()
    private var verificationID : String?
    
    func signUp(with number: String) -> Promises.Promise<Result<Void, Error>> {
        //
        
        
        let promise = Promise<Result<Void,Error>>.pending()
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { verificationID, error in
            guard let verificationID = verificationID, error == nil else {
                promise.fulfill(.failure(error!))
                return
            }
            promise.fulfill(.success(()))
            self.verificationID = verificationID
        }
        return promise
    }
    
    func verifyCode(with smsCode: String) -> Promises.Promise<Result<Void, Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        guard let verificationID = self.verificationID else {
            promise.fulfill(.failure(customError.someError))
            return promise
        }
        let credentials = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: smsCode)
        auth.signIn(with: credentials) { result, error in
            guard result != nil, error == nil else {
                promise.fulfill(.failure(error!))
                return
            }
            promise.fulfill(.success(()))
        }
        return promise
    }
    
}
