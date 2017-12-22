//
//  RefreshVC.swift
//  Home List
//
//  Created by Ravi on 21/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation
import UIKit

class RefreshVC: UIViewController {

    let container: UIView = UIView()
    let loadingView: UIView = UIView()
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()

    func showActivityIndicator() {
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.activityIndicatorViewStyle = .whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        view.addSubview(container)
        actInd.startAnimating()
    }

    func hideActivityIndicator() {
        container.removeFromSuperview()
    }
}
