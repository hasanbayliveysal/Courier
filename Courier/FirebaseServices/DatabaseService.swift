//
//  DatabaseService.swift
//  Courier
//
//  Created by Veysal on 6.05.2023.
//

import Foundation
import Promises
import FirebaseFirestore

protocol DatabaseServiceProtocol {
    func saveUsersInfo(with model : UserModel) -> Promise<Result<Void,Error>>
    func getUsersInfo() -> Promise<Result<[UserModel],Error>>
}


class DatabaseService: DatabaseServiceProtocol {

    
    let db = Firestore.firestore()
    func saveUsersInfo(with model : UserModel) -> Promises.Promise<Result<Void,Error>>{
        let promise = Promise<Result<Void,Error>>.pending()
        let userID = UserDefaults.standard.object(forKey: "number") as! String
        let jsonData = try? JSONEncoder().encode(model)
        let data = ["\(userID)" : jsonData!]
        db.collection("Users").document("\(userID)").setData(data, merge: true) { error in
            if let error = error {
                promise.fulfill(.failure(error))
            } else {
                promise.fulfill(.success(()))
            }
        }
        return promise
    }
    
    func getUsersInfo() -> Promises.Promise<Result<[UserModel],Error>>{
        let promise = Promise<Result<[UserModel],Error>>.pending()
        db.collection("Users").getDocuments { result, error in
            if let error = error {
                promise.fulfill(.failure(error))
            }else {
                var data : [UserModel] = []
                for document in result!.documents {
                    do{
                        let info = try JSONDecoder().decode(UserModel.self,from: document.data().first!.value as! Data)
                        data.append(info)
                    } catch let err{
                        print(err.localizedDescription)
                    }
    
                }
                promise.fulfill(.success(data))
            }
        }
        return promise
    }
    
    func updateUserInfo(model: UserModel) -> Promises.Promise<Result<Void,Error>> {
        let promise = Promise<Result<Void,Error>>.pending()
        let jsonData = try? JSONEncoder().encode(model)
        let num = UserDefaults.standard.object(forKey: "numforchangepassword") as! String
        let data = ["\(num)" : jsonData!]
        db.collection("Users").document(num).updateData(data) { error in
            if let error = error {
                promise.fulfill(.failure(error))
            }else {
                promise.fulfill(.success(()))
            }
        }
        return promise
    }
    
}
