//
//  ModularCollectionViewDelegate.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 03/01/2018.
//

import Foundation
import UIKit

public class PoqModularBagCollectionViewDelegate: NSObject, ModularCollectionViewDelegate {
    
    public var content: [PoqModularBagViewData]?
    public var cellBuilder: PoqModularBagCellBuilder?
    fileprivate var inEditMode: Bool = false
    public var didSelectItem: ((IndexPath) -> Void)?
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let contentUnwrapped = content else {
            print("Bag content is nil. The number of items should be zero but is not.")
            return CGSize.zero
        }
        
        return cellBuilder?.getSize(for: contentUnwrapped[indexPath.row]) ?? CGSize.zero
    }
    
    fileprivate func setEditMode(on cell: (UICollectionViewCell), animate: Bool = false) {
    
        if let editableCell = cell as? EditableCell {
            editableCell.setEditMode(to: inEditMode, animate: animate)
        }
    }
    
    public func setEditMode(on collectionView: UICollectionView, to inEditMode: Bool) {
       
        self.inEditMode = inEditMode
        
        collectionView.visibleCells.forEach { cell in
            setEditMode(on: cell, animate: true)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        setEditMode(on: cell, animate: false)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let tappableCell = collectionView.cellForItem(at: indexPath) as? TappableCell {
            
            tappableCell.actionOnTap()
        }
        
    }
}
