//
//  UIColor+RUI.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import UIKit

extension UIColor {

    static var brandPrimary: UIColor {
        return UIColor(named: "brandPrimary") ?? UIColor.red
    }

    static var backgroundGray: UIColor {
        return UIColor(named: "backgroundGray") ?? UIColor.gray
    }

    static var darkText: UIColor {
        return UIColor(named: "darkTextColor") ?? UIColor.darkGray
    }

    static var lightText: UIColor {
        return UIColor(named: "lightTextColor") ?? UIColor.lightGray
    }

    static var darkBrandPrimary: UIColor {
        return UIColor(named: "switchColor") ?? UIColor.red
    }

    static var filterBackgroundGray: UIColor {
        return UIColor(named: "filterBackgroundGray") ?? UIColor.red
    }

    static var brandGreen: UIColor {
        return UIColor(named: "brandGreen") ?? UIColor.red
    }
}
