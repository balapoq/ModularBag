//
//  ModularBagInteractor.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 11/12/2017.
//

import Foundation

public typealias ProductID  = (productId: Int, externalProductId: String)

public protocol ModularBagInteractor {

    typealias BagFetchCompletion = ([PoqModularBagViewData]) -> Void
    typealias BagFetchFailure = (Error?) -> Void

    var dataManager: ModularBagDataManager? { get }

    func fetchBag(callOnCompletion completion: @escaping BagFetchCompletion, callOnFailure failure: @escaping BagFetchFailure)

    func updateBag(callOnCompletion completion: @escaping BagFetchCompletion, callOnFailure failure: @escaping BagFetchFailure)
    
    func addContentHandler(_ handler: @escaping (ContentStore<PoqModularBagViewData>.Action?, [PoqModularBagViewData]?) -> Void)
    
    func initStore()
    
    func deleteBagItem(id: Int)
    
    var bagTotal: Decimal? { get }
    
    var numberOfItems: Int? { get }
    
    func updateBag()
    
    func updateQuantity(of bagItemId: Int, to quantity: Int)
    
    func updateWishlistStatus(id: Int, isWishlisted: Bool)
    
    func productID(for bagItemId: Int) -> ProductID?
}
