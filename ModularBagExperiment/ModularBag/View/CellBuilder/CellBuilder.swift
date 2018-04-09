//
//  CellBuilder.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 03/01/2018.
//

import Foundation
import UIKit

// Any cell requiring auto-sizing must adopt this protocol.
public protocol AutoSizeableCell {
    static var sizingCell: UICollectionViewCell? { get }
}

// CellBuilder provides forms the conduit between a ContentItem and the UICollectionViewCell associated with it.
// It provides the default implementation for getSize, which provides a size with the auto-layout constraint based height for the cell and a full screen width.
public protocol CellBuilder {
    associatedtype ContentType
    associatedtype DelegateType
    func getCellClass(for contentItem: ContentType) -> UICollectionViewCell.Type
    func setup(cell: UICollectionViewCell, with content: ContentType, delegate: DelegateType?)
    func getSize(for content: ContentType) -> CGSize
}

extension CellBuilder {
    public func getSize(for content: ContentType) -> CGSize {
        
        guard let autoSizableCell = getCellClass(for: content) as? AutoSizeableCell.Type else {
            print("The cell type for this content item is not AutoSizeable. Cannot calculate cell size for cells that are not of type AutoSizableCell")
            return CGSize.zero
        }
        
        guard let sizingCell = autoSizableCell.sizingCell else {
            print("Sizing Cell is nil. Unable to determine cell size for content type.")
            return CGSize.zero
        }
        
        sizingCell.prepareForReuse()
        
        setup(cell: sizingCell, with: content, delegate: nil)
        
        sizingCell.layoutIfNeeded()
        sizingCell.setNeedsLayout()
        
        let height = sizingCell.systemLayoutSizeFitting(UILayoutFittingExpandedSize).height
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }
}
