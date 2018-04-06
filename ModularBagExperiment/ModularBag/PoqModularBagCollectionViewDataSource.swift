//
//  PoqModularBagCollectionViewDataSource.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 03/01/2018.
//

import Foundation
import UIKit

public class PoqModularBagCollectionViewDataSource: NSObject, ModularCollectionViewDataSource {

    public typealias PresenterDelegate = ModularBagItemCellPresenter
    public var content: [PoqModularBagViewData]?
    public var cellBuilder: PoqModularBagCellBuilder?
    public var presenterDelegate: PresenterDelegate?
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let contentUnwrapped = content else {
            print("Bag content is nil. The number of items should be zero but is not.")
            return UICollectionViewCell()
        }
        
        guard let cellType = cellBuilder?.getCellClass(for: contentUnwrapped[indexPath.row]) else {
            print("Unable to determine cell type. CellTypeProvider might be nil.")
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.poqReuseIdentifier, for: indexPath)
        
        cellBuilder?.setup(cell: cell, with: contentUnwrapped[indexPath.row], delegate: presenterDelegate)
        
        return cell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content?.count ?? 0
    }
    
    public func updateCell(in collectionView: UICollectionView, at indexPath: IndexPath, with contentItem: PoqModularBagViewData) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            print("Unable to fetch cell at index \(indexPath.row) in order to update it.")
            return
        }
        
        cellBuilder?.setup(cell: cell, with: contentItem, delegate: presenterDelegate)
    }
}
