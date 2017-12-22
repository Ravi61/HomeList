//
//  TagCell.swift
//  Home List
//
//  Created by Ravi on 21/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import UIKit

struct TagModel {
    var name: String
    var selected: Bool
}

class TagCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bgView: RoundedView! {
        didSet {
            bgView.layer.borderWidth = 1
            bgView.layer.borderColor = UIColor.backgroundGray.cgColor
        }
    }
    
    var model: TagModel? {
        didSet {
            prepare()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepare() {
        nameLabel.text = model?.name ?? ""
        
        if model?.selected == true {
            bgView.layer.borderColor = UIColor.brandPrimary.cgColor
            nameLabel.textColor = UIColor.brandPrimary
        } else {
            bgView.layer.borderColor = UIColor.backgroundGray.cgColor
            nameLabel.textColor = UIColor.darkText
        }
    }
}
