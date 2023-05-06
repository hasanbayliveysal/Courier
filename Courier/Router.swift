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
    func signInVC() -> UIViewController
    func deliveriesVC() -> UIViewController
    func addressesVC() -> UIViewController
    func notificationsVC() -> UIViewController
    func moreVC() -> UIViewController
    func forgotPasswordVC() -> UIViewController
    func setnewPasswordVC() -> UIViewController
    
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
    public func signInVC() -> UIViewController {
        return SignInVC(vm: SignInVM(), router: self)
    }
    public func deliveriesVC() -> UIViewController {
        return DeliveriesVC(vm: DeliveriesVM(), router: self)
    }
    public func addressesVC() -> UIViewController {
        return AddressesVC(vm:AddressesVM(), router: self)
    }
    
    public func notificationsVC() -> UIViewController {
        return NotificationsVC(vm:NotificationsVM(), router: self)
    }
    
    public func moreVC() -> UIViewController {
       return MoreVC(vm:MoreVM(), router: self)
    }
    public func forgotPasswordVC() -> UIViewController {
        return ForgotPasswordVC(vm: ForgotPasswordVM() , router: self)
    }
    
    public func setnewPasswordVC() -> UIViewController {
        return SetNewPasswordVC(vm: SetNewPasswordVM() , router: self)
    }
    

    
    
}
