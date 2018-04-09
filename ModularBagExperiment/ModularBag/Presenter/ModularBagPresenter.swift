//
//  ModularBagPresenter.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 11/12/2017.
//

import Foundation

public protocol ModularBagPresenter {
    
    var interactor: ModularBagInteractor? { get }
    var router: ModularBagRouter? { get }
    var viewState: BagViewState? { get }
    var inEditMode: Bool? { get }
    
    func addViewStateHandler(_ handler: @escaping (BagViewState.Action?) -> Void)
    
    func addContentHandler(_ handler: @escaping(ContentStore<PoqModularBagViewData>.Action?, [PoqModularBagViewData]?) -> Void)
    
    func toggleEditMode()
    func presentCheckout()
    func viewWillAppear()
    func viewDidLoad()
    
    var numberOfItems: Int { get }
    var bagTotal: Decimal { get }
    func deleteBagItem(id: Int)
    func updateQuantity(of bagItemId: Int, to quantity: Int)
    func didTapOnBagItem(id: Int)
    func updateWishlistStatus(id: Int, isWishlisted: Bool)
}
