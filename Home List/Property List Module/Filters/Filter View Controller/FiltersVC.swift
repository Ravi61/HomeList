//
//  FiltersVC.swift
//  Home List
//
//  Created by Ravi on 21/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum Filter {
    case apartmentType
    case propertyType
    case furnishing
}

enum ApartmentType: String {
    case rk = "1 RK"
    case oneBHK = "1 BHK"
    case twoBHK = "2 BHK"
    case threeBHK = "3 BHK"
    case fourBHK = "4 BHK"
    case moreBHK = "4+ BHK"
    
    func getAPIValue() -> String {
        switch self {
        case .rk:
            return "RK1"
        case .oneBHK:
            return "BHK1"
        case .twoBHK:
            return "BHK2"
        case .threeBHK:
            return "BHK3"
        case .fourBHK:
            return "BHK4"
        case .moreBHK:
            return "BHK4P"
        }
    }
}

enum Property: String {
    case apartment = "Apartment"
    case independentHouse = "Independent House/Villa"
    case independentFloor = "Independent Floor/Builder Floor"
    
    func getAPIValue() -> String {
        switch self {
        case .apartment:
            return "AP"
        case .independentHouse:
            return "IH"
        case .independentFloor:
            return "IF"
        }
    }
}

class FiltersVC: UIViewController {

    @IBOutlet weak var searchIconLabel: UILabel! {
        didSet {
            searchIconLabel.textColor = UIColor.brandGreen
            searchIconLabel.text = AppConstants.FontIcon.search
            searchIconLabel.font = UIFont.fontIcon(ofSize: 22)
            searchIconLabel.textAlignment = .center
        }
    }
    @IBOutlet weak var searchTextfield: UITextField! {
        didSet {
            searchTextfield.placeholder = "Search by Locality or Landmark"
            searchTextfield.tintColor = UIColor.brandPrimary
            searchTextfield.font = UIFont.helvetica(withSize: 16)
        }
    }
    @IBOutlet weak var filtersTable: UITableView! {
        didSet {
            filtersTable.registerCell(withIdentifier: ApartmentTypeCell.className)
            filtersTable.rowHeight = UITableViewAutomaticDimension
            filtersTable.estimatedRowHeight = 200
            filtersTable.delegate = self
            filtersTable.dataSource = self
            filtersTable.backgroundColor = UIColor.clear
            filtersTable.separatorStyle = .none
            filtersTable.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var applyButton: UIButton! {
        didSet {
            applyButton.backgroundColor = UIColor.brandPrimary
            applyButton.setTitle("Apply", for: .normal)
            applyButton.titleLabel?.font = UIFont.helveticaBold(withSize: 16)
            applyButton.setTitleColor(.white, for: .normal)
        }
    }
    
    var viewModel: FilterViewModel?
    
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupFilterNavigationBar(title: "FILTER BY", closeSelector: #selector(closeSelected), refreshSelector: #selector(refreshSelected))
        setupDependency()
    }
    
    func setupDependency() {
        guard let viewModel = viewModel else { return }

        viewModel.dismissTrigger.subscribe(onNext: { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: bag)
        
        applyButton.rx
            .tap
            .bind(to: viewModel.applyButtonTapped)
            .disposed(by: bag)
    }
    
    @objc func closeSelected() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func refreshSelected() {
        viewModel?.refreshTrigger.onNext(())
        filtersTable.reloadData()
    }
}

extension FiltersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ApartmentTypeCell.className, for: indexPath) as! ApartmentTypeCell
        cell.viewModel = viewModel?.items.value[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.value.count ?? 0
    }
}
