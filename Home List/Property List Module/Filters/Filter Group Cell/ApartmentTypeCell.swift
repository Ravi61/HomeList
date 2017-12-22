//
//  ApartmentTypeCell.swift
//  Home List
//
//  Created by Ravi on 21/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ApartmentTypeCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var tagsCollectionView: UICollectionView! {
        didSet {
            tagsCollectionView.register(UINib(nibName: TagCell.className, bundle: nil), forCellWithReuseIdentifier: TagCell.className)
            let tagLayout = TagCellLayout(tagAlignmentType: .Left, delegate: self)
            tagsCollectionView.collectionViewLayout = tagLayout
            tagsCollectionView.dataSource = self
            tagsCollectionView.delegate = self
            tagsCollectionView.backgroundColor = UIColor.clear
        }
    }
    
    var viewModel: ApartmentTypeCellViewModel? {
        didSet {
            setupDependency()
        }
    }
    private let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
    }
    
    func setupDependency() {
        self.typeLabel.text = viewModel?.titleString.value ?? ""
        tagsCollectionView.reloadData()
    }
}

extension ApartmentTypeCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.className, for: indexPath) as! TagCell
        cell.model = viewModel?.items.value[indexPath.row]
        return cell
    }
}

extension ApartmentTypeCell: TagCellLayoutDelegate, UICollectionViewDelegate {
    
    func tagCellLayoutTagWidth(layout: TagCellLayout, atIndex index: Int) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = viewModel?.items.value[index].name ?? ""
        label.sizeToFit()
        return label.frame.size.width + 40
    }
    
    func tagCellLayoutTagFixHeight(layout: TagCellLayout) -> CGFloat {
        return 54
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.itemSelected.onNext(indexPath.row)
        collectionView.reloadData()
    }
}
