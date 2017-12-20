//
//  String+RUI.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import UIKit

extension String {
    static func attributed(string: String, color: UIColor, font: UIFont) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string,
                                         attributes: [
                                             NSAttributedStringKey.font: font,
                                             NSAttributedStringKey.foregroundColor: color
        ])
    }
}
