//
//  PaymentConfig.swift
//  BruinBuzz
//
//  Created by Jeremy Dimas on 5/3/24.
//

import Foundation

class PaymentConfig
{
    var paymentIntentClientSecret: String?
    static var shared: PaymentConfig = PaymentConfig()
    private init(){}
    
}
