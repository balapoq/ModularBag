//
//  PoqModularBagCellBuilder.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 03/01/2018.
//

import Foundation
import UIKit

// The default CellBuilder class for PoqModularBagViewData ContentType
public class PoqModularBagCellBuilder: CellBuilder {
    
    public typealias ContentType = PoqModularBagViewData
    public typealias DelegateType = ModularBagItemCellPresenter
    
    public init() { }
    
    public func getCellClass(for contentItem: ContentType) -> UICollectionViewCell.Type {
        
        switch contentItem {
        case PoqModularBagViewData.bagItemCard :
            return ModularBagItemCell.self
        default:
            return UICollectionViewCell.self
        }
    }
    
    public func setup(cell: UICollectionViewCell, with content: ContentType, delegate: ModularBagItemCellPresenter?) {
        
        switch content {
            
        case PoqModularBagViewData.bagItemCard(let bagItem) :
            
            guard let bagItemCardCell = cell as? ModularBagItemCell else {
                print("Cell type and content item type do not match. Cannot setup cell")
                return
            }
            
            bagItemCardCell.setup(with: bagItem, delegate: delegate)
            
        default:
            return
        }
        
    }
}
