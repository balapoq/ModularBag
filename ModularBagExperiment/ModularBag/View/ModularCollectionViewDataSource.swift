//
//  ModularCollectionViewDataSource.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 03/01/2018.
//

import Foundation
import UIKit

public protocol ModularCollectionViewDataSource: UICollectionViewDataSource {

    var presenterDelegate: ModularBagItemCellPresenter? { get set }
    var cellBuilder: PoqModularBagCellBuilder? { get set }
    var content: [PoqModularBagViewData]? { get set }
    func registerCells(with collectionView: UICollectionView)
    func updateCell(in collectionView: UICollectionView, at indexPath: IndexPath, with contentItem: PoqModularBagViewData)
}

extension ModularCollectionViewDataSource {
    public func registerCells(with collectionView: UICollectionView) {
        var cellClassesToRegister = [UICollectionViewCell.Type]()
        content?.forEach { contentItem in
            if let cellType = cellBuilder?.getCellClass(for: contentItem) {
                if !cellClassesToRegister.contains(where: { $0 == cellType }) {
                    cellClassesToRegister.append(cellType)
                }
            }
        }
        
        collectionView.registerPoqCells(cellClasses: cellClassesToRegister)
    }
}
