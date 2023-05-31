//
//  DeliveryModel.swift
//  Courier
//
//  Created by Veysal on 15.05.2023.
//

import Foundation


struct OrdersModel : Codable {
    let name: String
    let date: String
    let price: String
}

struct DeliveryInformationModel : Codable {
    let name: String
    let width: String
    let height: String
    let length: String
    let weigth: String
    let easilyBroken: Bool
}

struct DeliveryAddressModel: Codable {
    let whereFrom: String
    let whereTo: String
    let nonContactDelivery: Bool
    let RecipientName: String
    let RecipientNum: String
}

struct ConfirmDeliveryModel: Codable {
    let address: String
    let time: String
    let paymentMethod: PaymentModel
}


struct PaymentModel : Codable {
    let cash: Bool
    let card: CardModel
}

struct CardModel: Codable {
    let cardNumber: String
    let cardExpireDate: String
    let cvv: String
}
