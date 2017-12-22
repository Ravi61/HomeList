//
//  TagCellLayout.swift
//  TagCellLayout
//
//  Created by Ravi on 21/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation
import UIKit

protocol TagCellLayoutDelegate: NSObjectProtocol {
    func tagCellLayoutTagWidth(layout: TagCellLayout, atIndex index:Int) -> CGFloat
    func tagCellLayoutTagFixHeight(layout: TagCellLayout) -> CGFloat
}

enum TagAlignmentType: Int {
    case Left
    case Center
    case Right
    
    var distributionFactor: CGFloat {
        var factor: CGFloat
        switch self {
        case .Center:
            factor = 2
        default:
            factor = 1
        }
        return factor
    }
}

class TagCellLayout: UICollectionViewLayout {
    
    struct TagCellLayoutInfo {
        var layoutAttribute: UICollectionViewLayoutAttributes
        var whiteSpace: CGFloat
        
        init(layoutAttribute: UICollectionViewLayoutAttributes) {
            self.layoutAttribute = layoutAttribute
            self.whiteSpace = 0
        }
    }
    
    var layoutInfoList = Array<TagCellLayoutInfo>()
    var tagAlignmentType = TagAlignmentType.Left
    var numberOfTagsInCurrentRow = 0
    var currentTagIndex: Int = 0
    var lineNumber = 1
    weak var delegate: TagCellLayoutDelegate?
    
    var currentTagPosition: CGPoint {
        if let info = currentTagLayoutInfo?.layoutAttribute {
            var position = info.frame.origin
            position.x += info.bounds.width
            return position
        }
        return .zero
    }
    
    var currentTagLayoutInfo: TagCellLayoutInfo? {
        let index = max(0, currentTagIndex - 1)
        if layoutInfoList.count > index {
            return layoutInfoList[index]
        }
        return nil
    }
    
    var tagsCount: Int {
        return collectionView?.numberOfItems(inSection: 0) ?? 0
    }
    
    var collectionViewWidth: CGFloat {
        return collectionView?.frame.size.width ?? 0
    }
    
    var isLastRow: Bool {
        return currentTagIndex == (tagsCount - 1)
    }
    
    //MARK: - Init Methods
    
    init(tagAlignmentType: TagAlignmentType = .Left, delegate: TagCellLayoutDelegate?) {
        super.init()
        self.delegate = delegate
        self.tagAlignmentType = tagAlignmentType
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override convenience init() {
        self.init(delegate: nil)
    }
    
    //MARK: - Override Methods
    
    override func prepare() {
        resetLayoutState()
        setupTagCellLayout()
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if layoutInfoList.count > indexPath.row {
            return layoutInfoList[indexPath.row].layoutAttribute
        }
        
        return nil
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if layoutInfoList.count > 0 {
            let visibleLayoutAttributes = layoutInfoList
                .map { $0.layoutAttribute }
                .filter { rect.intersects($0.frame) }
            return visibleLayoutAttributes
        }
        return nil
    }
    
    override var collectionViewContentSize: CGSize {
        if let
            heightPerLine = delegate?.tagCellLayoutTagFixHeight(layout: self),
            let width = collectionView?.frame.size.width
        {
            let height = heightPerLine*CGFloat(lineNumber)
            return CGSize(width: width, height: height)
        }
        return CGSize.zero
    }
    
    class func textWidth(text: String, font: UIFont) -> CGFloat {
        let padding: CGFloat = 4 // this number is independent of font and is required to compensate the inaccuracy of sizeToFit calculation!
        let label = UILabel()
        label.text = text
        label.font = font
        label.sizeToFit()
        let frame = label.frame
        return (frame.width + padding)
    }
}

//MARK: - Private Methods

private extension TagCellLayout {
    
    func setupTagCellLayout() {
        // delegate and collectionview shouldn't be nil
        if let delegate = delegate , let _ = collectionView {
            // basic layout setup which is independent of TagAlignment type
            basicLayoutSetup(delegate: delegate)
            
            // handle if TagAlignment is other than Left
            handleTagAlignment()
            
        } else {
            // otherwise thorwing an error
            handleErrorState()
        }
    }
    
    func basicLayoutSetup(delegate: TagCellLayoutDelegate) {
        // asking the client for a fixed tag height
        
        // iterating over every tag and constructing its layout attribute
        for tagIndex in 0 ..< tagsCount {
            currentTagIndex = tagIndex
            
            // creating layout and adding it to the dataSource
            createLayoutAttributes()
            
            // configuring white space info || this is later used for .Right or .Center alignment
            configureWhiteSpace()
            
            // processing info for next tag || setting up the coordinates for next tag
            configurePositionForNextTag()
            
            // handling tha layout for last row separately
            handleWhiteSpaceForLastRow()
        }
    }
    
    func createLayoutAttributes() {
        if let delegate = delegate {
            // calculating tag-size
            let tagHeight = delegate.tagCellLayoutTagFixHeight(layout: self)
            let tagWidth = delegate.tagCellLayoutTagWidth(layout: self, atIndex: currentTagIndex)
            let tagSize = CGSize(width: tagWidth, height: tagHeight)
            
            let layoutInfo = tagCellLayoutInfo(tagIndex: currentTagIndex, tagSize: tagSize)
            layoutInfoList.append(layoutInfo)
        }
    }
    
    func tagCellLayoutInfo(tagIndex: Int, tagSize: CGSize) -> TagCellLayoutInfo {
        // local data-structure (TagCellLayoutInfo) that has been used in this library to store attribute and white-space info
        var tagFrame = CGRect(origin: currentTagPosition, size: tagSize)
        
        // if next tag goes out of screen then move it to next row
        if shouldMoveTagToNextRow(tagWidth: tagSize.width) {
            tagFrame.origin.x = 0
            tagFrame.origin.y += tagSize.height
        }
        let attribute = layoutAttribute(tagIndex: tagIndex, tagFrame: tagFrame)
        let info = TagCellLayoutInfo(layoutAttribute: attribute)
        return info
    }
    
    func shouldMoveTagToNextRow(tagWidth: CGFloat) -> Bool {
        return ((currentTagPosition.x + tagWidth) > collectionViewWidth)
    }
    
    func layoutAttribute(tagIndex: Int, tagFrame: CGRect) -> UICollectionViewLayoutAttributes {
        let indexPath = IndexPath(item: tagIndex, section: 0)
        let layoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        layoutAttribute.frame = tagFrame
        return layoutAttribute
    }
    
    func configureWhiteSpace() {
        let layoutInfo = layoutInfoList[currentTagIndex].layoutAttribute
        let tagWidth = layoutInfo.frame.size.width
        if shouldMoveTagToNextRow(tagWidth: tagWidth) {
            lineNumber += 1
            applyWhiteSpace(startingIndex: (currentTagIndex - 1))
        }
    }
    
    func applyWhiteSpace(startingIndex: Int) {
        let lastIndex = startingIndex - numberOfTagsInCurrentRow
        let whiteSpace = calculateWhiteSpace(tagIndex: startingIndex)
        
        for tagIndex in (lastIndex+1) ..< (startingIndex+1) {
            insertWhiteSpace(tagIndex: tagIndex, whiteSpace: whiteSpace)
        }
    }
    
    func calculateWhiteSpace(tagIndex: Int) -> CGFloat {
        let tagFrame = tagFrameForIndex(tagIndex: tagIndex)
        let whiteSpace = collectionViewWidth - (tagFrame.origin.x + tagFrame.size.width)
        return whiteSpace
    }
    
    func insertWhiteSpace(tagIndex: Int, whiteSpace: CGFloat) {
        var info = layoutInfoList[tagIndex]
        let factor = tagAlignmentType.distributionFactor
        info.whiteSpace = whiteSpace/factor
        layoutInfoList[tagIndex] = info
    }
    
    func tagFrameForIndex(tagIndex: Int) -> CGRect {
        let tagFrame =  tagIndex > -1 ? layoutInfoList[tagIndex].layoutAttribute.frame : .zero
        return tagFrame
    }
    
    func configurePositionForNextTag() {
        let layoutInfo = layoutInfoList[currentTagIndex].layoutAttribute
        let moveTag = shouldMoveTagToNextRow(tagWidth: layoutInfo.frame.size.width)
        numberOfTagsInCurrentRow = moveTag ? 1 : (numberOfTagsInCurrentRow + 1)
    }
    
    func handleTagAlignment() {
        if let collectionView = collectionView {
            if tagAlignmentType != .Left {
                let tagsCount = collectionView.numberOfItems(inSection: 0)
                for tagIndex in 0 ..< tagsCount {
                    var tagFrame = layoutInfoList[tagIndex].layoutAttribute.frame
                    let whiteSpace = layoutInfoList[tagIndex].whiteSpace
                    tagFrame.origin.x += whiteSpace
                    let tagAttribute = layoutAttribute(tagIndex: tagIndex, tagFrame: tagFrame)
                    layoutInfoList[tagIndex].layoutAttribute = tagAttribute
                }
            }
        }
    }
    
    func handleWhiteSpaceForLastRow() {
        if isLastRow {
            applyWhiteSpace(startingIndex: (tagsCount-1))
        }
    }
    
    func handleErrorState() {
        print("TagCollectionViewCellLayout is not properly configured")
    }
    
    func resetLayoutState() {
        layoutInfoList = Array<TagCellLayoutInfo>()
        numberOfTagsInCurrentRow = 0
        lineNumber = 1
    }
    
}

