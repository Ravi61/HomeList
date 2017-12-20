//
//  Int+RUI.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation

extension Int {
    func formatAsMoney() -> String {

        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 0
        currencyFormatter.locale = Locale(identifier: "en_IN")

        let amountString = currencyFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
        return amountString
    }
}
