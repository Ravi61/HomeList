//
//  PropertyListVC.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PropertyListVC: RefreshVC, UITableViewDelegate {

    @IBOutlet weak var propertyList: UITableView! {
        didSet {
            propertyList.tableFooterView = UIView()
            propertyList.separatorStyle = .none
            propertyList.backgroundColor = UIColor.backgroundGray
            propertyList.setAutomaticDimension()
            propertyList.registerCell(withIdentifier: PropertyCardListCell.className)
            propertyList.delegate = self
        }
    }

    @IBOutlet weak var filterButton: UIButton! {
        didSet {
            let title = String.attributed(string: AppConstants.FontIcon.filter,
                                          color: .white, font: .fontIcon(ofSize: 26))
            filterButton.setAttributedTitle(title, for: .normal)
            filterButton.backgroundColor = UIColor.brandPrimary
            filterButton.layer.cornerRadius = filterButton.bounds.width / 2
            filterButton.clipsToBounds = true
        }
    }

    var viewModel: PropertyListViewModelRepresentable?
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationBar(title: "Properties near me")
        setupDependency()
    }

    func setupDependency() {
        guard let viewModel = viewModel else { return }

        viewModel.tableItemsFetched.bind(to: propertyList.rx.items) { _, row, cellViewModel in
            let cell = self.propertyList.dequeueCellOfType(PropertyCardListCell.self, forIndex: IndexPath(row: row,
                                                                                                          section: 0))
            cell.viewModel = cellViewModel
            cell.selectionStyle = .none
            viewModel.checkPagination.onNext(row)
            return cell
        }.disposed(by: bag)

        viewModel.loaderTrigger.subscribe(onNext: { [unowned self] state in
            switch state {
            case .animate:
                self.showActivityIndicator()
            case .stop:
                self.hideActivityIndicator()
            }
        }).disposed(by: bag)

        filterButton.rx
            .tap
            .bind(to: viewModel.filterTapped)
            .disposed(by: bag)

        viewModel.filterTrigger.subscribe(onNext: { [unowned self] model in
            let controller = FiltersVC.instantiate(fromAppStoryboard: .home)
            controller.viewModel = model
            let nvc = UINavigationController(rootViewController: controller)
            self.present(nvc, animated: true, completion: nil)
        }).disposed(by: bag)
    }
}
