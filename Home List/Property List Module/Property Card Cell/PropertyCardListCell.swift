//
//  PropertyCardListCell.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class PropertyCardListCell: UITableViewCell {

    @IBOutlet weak var sponsoredImage: UIImageView! {
        didSet {
            sponsoredImage.contentMode = .scaleAspectFit
            sponsoredImage.backgroundColor = UIColor.clear
            sponsoredImage.image = #imageLiteral(resourceName: "sponsoredIcon")
        }
    }

    @IBOutlet weak var propertyNameLabel: UILabel! {
        didSet {
            propertyNameLabel.text = ""
            propertyNameLabel.textColor = UIColor.darkText
            propertyNameLabel.font = UIFont.helveticaBold(withSize: 16)
        }
    }

    @IBOutlet weak var propertyAddressLabel: UILabel! {
        didSet {
            propertyAddressLabel.text = ""
            propertyAddressLabel.textColor = UIColor.lightText
            propertyAddressLabel.font = UIFont.helvetica(withSize: 14)
        }
    }

    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var callButton: UIButton! {
        didSet {
            let title = String.attributed(string: AppConstants.FontIcon.call,
                                          color: .brandPrimary, font: .fontIcon(ofSize: 26))
            callButton.setAttributedTitle(title, for: .normal)
        }
    }

    @IBOutlet weak var displayImage: UIImageView! {
        didSet {
            displayImage.contentMode = .scaleAspectFill
            displayImage.clipsToBounds = true
        }
    }

    @IBOutlet weak var amountLabel: UILabel! {
        didSet {
            amountLabel.text = ""
            amountLabel.textColor = UIColor.darkText
            amountLabel.font = UIFont.helveticaBold(withSize: 18)
            amountLabel.textAlignment = .center
            amountLabel.numberOfLines = 0
        }
    }

    @IBOutlet weak var descLabel: UILabel! {
        didSet {
            descLabel.text = ""
            descLabel.textColor = UIColor.lightText
            descLabel.font = UIFont.helveticaLight(withSize: 14)
            descLabel.textAlignment = .center
            descLabel.numberOfLines = 0
        }
    }

    @IBOutlet weak var areaLabel: UILabel! {
        didSet {
            areaLabel.text = ""
            areaLabel.textAlignment = .center
            areaLabel.numberOfLines = 0
        }
    }

    @IBOutlet weak var sponsoredImageWidthConstraint: NSLayoutConstraint!

    var viewModel: PropertyCardListViewModelRepresentable? {
        didSet {
            setupDependency()
        }
    }

    private let bag = DisposeBag()

    override func prepareForReuse() {
        viewModel = nil
        sponsoredImageWidthConstraint.constant = 30
    }

    override func awakeFromNib() {
        backgroundColor = UIColor.clear
    }

    func setupDependency() {
        guard let viewModel = viewModel else { return }

        viewModel.sponsoredImageWidthTrigger.subscribe(onNext: { [unowned self] width in
            self.sponsoredImageWidthConstraint.constant = CGFloat(width)
        }).disposed(by: bag)

        viewModel.propertyAmount.subscribe(onNext: { [unowned self] amount in
            self.amountLabel.text = amount
        }).disposed(by: bag)

        viewModel.propertyArea.subscribe(onNext: { [unowned self] area in
            let areaAttributedString = String.attributed(string: "\(area) Sq. ft", color: .darkGray, font: .helveticaBold(withSize: 16))
            let subtitleAttributedString = String.attributed(string: "\nBuilt up Area", color: .lightText, font: .helveticaLight(withSize: 14))
            areaAttributedString.append(subtitleAttributedString)

            self.areaLabel.attributedText = areaAttributedString
        }).disposed(by: bag)

        viewModel.propertyBasicDetails.subscribe(onNext: { [unowned self] name, address in
            self.propertyNameLabel.text = name
            self.propertyAddressLabel.text = address
        }).disposed(by: bag)

        viewModel.propertyDesc.subscribe(onNext: { [unowned self] desc in
            self.descLabel.text = desc
        }).disposed(by: bag)

        favouriteButton.rx
            .tap.debug("favourite button pressed \(self.propertyNameLabel.text!)")
            .bind(to: viewModel.favouriteButtonTrigger).disposed(by: bag)

        viewModel.favouriteSelectionTrigger.debug("favourite button change \(self.propertyNameLabel.text!)").subscribe(onNext: { [unowned self] state in
            if state {
                let selectedTitle = String.attributed(string: AppConstants.FontIcon.favoriteFillled,
                                                      color: .brandPrimary, font: .fontIcon(ofSize: 26))
                self.favouriteButton.setAttributedTitle(selectedTitle, for: .normal)
            } else {
                let unselectedTitle = String.attributed(string: AppConstants.FontIcon.favouriteUnfilled,
                                                        color: .darkText, font: .fontIcon(ofSize: 26))
                self.favouriteButton.setAttributedTitle(unselectedTitle, for: .normal)
            }
        }).disposed(by: bag)

        viewModel.photoURL.subscribe(onNext: { [unowned self] urlString in
            DispatchQueue.main.async {
                self.displayImage.sd_setShowActivityIndicatorView(true)
                self.displayImage.sd_setImage(with: URL(string: urlString), completed: nil)
            }
        }).disposed(by: bag)

        callButton.rx
            .tap
            .map {
                return "1234567890"
            }.debug("call button press \(self.propertyNameLabel.text!)").bind(to: viewModel.callButtonTrigger).disposed(by: bag)
    }
}
