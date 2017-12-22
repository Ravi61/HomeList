//
//  UIViewController+RUI.swift
//  Home List
//
//  Created by Ravi on 21/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import UIKit

extension UIViewController {

    func setupNavigationBar(title: String) {
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let backTitle = String.attributed(string: AppConstants.FontIcon.leftArrow, color: .white, font: .fontIcon(ofSize: 22))
        backButton.setAttributedTitle(backTitle, for: .normal)

        let backBarButton = UIBarButtonItem(customView: backButton)

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 64))
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.helveticaBold(withSize: 18)
        titleLabel.sizeToFit()

        let titleItem = UIBarButtonItem(customView: titleLabel)

        navigationItem.leftBarButtonItems = [backBarButton, titleItem]

        let mapSwitch = UISwitch(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        mapSwitch.tintColor = UIColor.darkBrandPrimary
        mapSwitch.onTintColor = UIColor.darkBrandPrimary
        mapSwitch.sizeToFit()
        let switchRightBarItem = UIBarButtonItem(customView: mapSwitch)

        let searchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 64))
        let title = String.attributed(string: AppConstants.FontIcon.search, color: .white, font: .fontIcon(ofSize: 22))
        searchButton.setAttributedTitle(title, for: .normal)
        let searchRightBarButton = UIBarButtonItem(customView: searchButton)

        navigationItem.rightBarButtonItems = [searchRightBarButton, switchRightBarItem]

        navigationController?.navigationBar.barTintColor = UIColor.brandPrimary
    }

    func setupFilterNavigationBar(title: String, closeSelector: Selector, refreshSelector: Selector) {
        let refreshButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let refreshTitle = String.attributed(string: AppConstants.FontIcon.refresh, color: .white, font: .fontIcon(ofSize: 20))
        refreshButton.setAttributedTitle(refreshTitle, for: .normal)
        refreshButton.addTarget(self, action: refreshSelector, for: .touchUpInside)
        let refreshBarButton = UIBarButtonItem(customView: refreshButton)
        navigationItem.leftBarButtonItems = [refreshBarButton]

        navigationItem.title = title
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        let closeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 64))
        let title = String.attributed(string: AppConstants.FontIcon.close, color: .white, font: .fontIcon(ofSize: 18))
        closeButton.setAttributedTitle(title, for: .normal)
        closeButton.addTarget(self, action: closeSelector, for: .touchUpInside)
        let closeRightBarButton = UIBarButtonItem(customView: closeButton)
        navigationItem.rightBarButtonItems = [closeRightBarButton]

        navigationController?.navigationBar.barTintColor = UIColor.brandPrimary
    }
}
