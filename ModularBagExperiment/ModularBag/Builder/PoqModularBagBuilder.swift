//
//  PoqModularBagBuilder.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 03/01/2018.
//

import Foundation
import UIKit

public class PoqModularBagBuilder: ModularBagBuilder {
    
    public func buildModularBag() -> UIViewController {
        
        typealias DataManagerType = PoqClassicBagDataManager
        typealias ContentBlockBuilderType = PoqClassicBagContentBlockBuilder
        typealias ViewDataType = PoqModularBagViewData
        typealias InteractorType = PoqModularBagInteractor
        typealias PresenterType = PoqModularBagPresenter
        typealias CellBuilderType = PoqModularBagCellBuilder
        typealias DataSourceType = PoqModularBagCollectionViewDataSource
        typealias DelegateType = PoqModularBagCollectionViewDelegate
        
        let dataManager = DataManagerType()
        
        let bagContentBuilder = ContentBlockBuilderType()
        let interactor = InteractorType()
        interactor.dataManager = dataManager
        interactor.contentBlockBuilder = bagContentBuilder
        
        let router = PoqModularBagRouter()

        let presenter = PresenterType()
        presenter.interactor = interactor
        presenter.router = router
        
        let cellBuilder = CellBuilderType()
        
        let delegate = DelegateType()
        delegate.cellBuilder = cellBuilder
        
        let viewController = PoqModularBagViewController(nibName: "PoqModularBagView", bundle: Bundle(identifier: "com.poq.platform"))
        viewController.presenter = presenter
        
        let dataSource = DataSourceType()
        dataSource.cellBuilder = cellBuilder
        dataSource.presenterDelegate = viewController
        viewController.collectionViewDataSource = dataSource
        
        viewController.collectionViewDelegate = delegate
        
        return viewController
    }
}
