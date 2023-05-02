//
//  Router.swift
//  Courier
//
//  Created by Veysal on 30.04.2023.
//

import UIKit

public protocol RouterProtocol {
    
    func welcomeVC() -> UIViewController
    func signUpVC() -> UIViewController
    func verifyNumVC(num: String) -> UIViewController
    func createPasswordVC() -> UIViewController
    
}

public class Router: RouterProtocol {
    
    public func welcomeVC() -> UIViewController {
        return WelcomeVC(vm:WelcomeVM(), router: self)
    }
    
    public func signUpVC() -> UIViewController {
        return SignUpVC(vm: SignUpVM(), router: self)
    }
    
    public func verifyNumVC(num: String) -> UIViewController {
        return VerifyNumVC(vm: VerifyNumVM(number: num), router: self)
    }
    
    public func createPasswordVC() -> UIViewController {
        return CreatePasswordVC(vm: CreatePasswordVM(), router: self)
    }
}
