//
//  UIFont+RUI.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import UIKit

extension UIFont {
    static func helveticaBold(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
    static func helveticaLight(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func helvetica(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func fontIcon(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "icomoon", size: size)!
    }
}
