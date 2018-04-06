//
//  ModularCollectionViewDelegate.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 03/01/2018.
//

import Foundation
import UIKit

public protocol ModularCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    
    var content: [PoqModularBagViewData]? { get set }
    var cellBuilder: PoqModularBagCellBuilder? { get set }
    
    func setEditMode(on collectionView: UICollectionView, to inEditMode: Bool)
}
