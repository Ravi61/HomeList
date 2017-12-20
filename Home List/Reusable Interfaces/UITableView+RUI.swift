//
//  UITableView+RUI.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import UIKit

extension UITableView {

    func registerCell(withIdentifier identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func setAutomaticDimension() {
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 200
    }

    func dequeueCellOfType<T>(_: T.Type, forIndex indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Could not dequeue cell")
        }
        return cell
    }
}
