//
//  CardView.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: RoundedView {

    @IBInspectable var shadowOffsetWidth: CGFloat = 0 {
        didSet {
            self.layer.shadowOffset.width = shadowOffsetWidth
        }
    }

    @IBInspectable var shadowOffsetHeight: CGFloat = 3 {
        didSet {
            self.layer.shadowOffset.height = shadowOffsetHeight
        }
    }

    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.2 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }

    override func setupLayer() {
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
    }

    func removeCardView() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0
    }
}
