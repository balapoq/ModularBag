//
//  PoqModularBagPresenter.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 03/01/2018.
//

import Foundation

public class PoqModularBagPresenter: ModularBagPresenter {
    
    public typealias ContentType = PoqModularBagViewData
    
    public var interactor: ModularBagInteractor?
    public var router: ModularBagRouter?
    public var viewState: BagViewState?
    
    public var inEditMode: Bool? {
        
        return viewState?.inEditMode
    }
    
    public init() {
        
        viewState = BagViewState()
        
    }
    
    public func fetchBagItems(callWhenBagReadyForDisplay: @escaping ([ContentType]) -> Void, callOnErrorFetchingBag: @escaping (String?) -> Void) {
        
        interactor?.fetchBag(callOnCompletion: callWhenBagReadyForDisplay, callOnFailure: { error in
            callOnErrorFetchingBag(error?.localizedDescription)
        })
    }
    
    public func viewWillAppear() {
        
        // We don't want to update the bag if the user is in the process of Editing it.
        if !(inEditMode ?? false) {
            
            viewState?.loading()
            interactor?.fetchBag()
            
        }
    }
    
    public func viewDidLoad() {
        
        interactor?.initStore()
    }
    
    public func presentCheckout() {
        
        router?.navigateToCheckout()
    }
    
    public func addViewStateHandler(_ handler: @escaping (BagViewState.Action?) -> Void) {
        
        viewState?.add(handler: handler)
    }
    
    public func addContentHandler(_ handler: @escaping (ContentStore<ContentType>.Action?, [ContentType]?) -> Void) {
        
        interactor?.addContentHandler(handler)
    }
    
    public func toggleEditMode() {
        
        if inEditMode ?? false {
            
            interactor?.updateBag()
            viewState?.loading()
        }
        
        viewState?.toggleEditMode()
    }
    
    public var bagTotal: Decimal {
        
        guard let bagTotal =  interactor?.bagTotal else {
            
            print("Unable to fetch bagTotal")
            return 0
        }
        
        return bagTotal
    }
    
    public var numberOfItems: Int {
        
        guard let numberOfItems =  interactor?.numberOfItems else {
            
            print("Unable to fetch numberOfItems")
            return 0
        }
        
        return numberOfItems
    }
    
    public func deleteBagItem(id: Int) {
     
        interactor?.deleteBagItem(id: id)
        
        // Not in edit mode. Swipe to delete. Update right away.
        if !(inEditMode ?? false) {
            
            interactor?.updateBag()
            viewState?.loading()
        }
    }
    
    public func updateQuantity(of bagItemId: Int, to quantity: Int) {
        
        interactor?.updateQuantity(of: bagItemId, to: quantity)
    }
    
    public func didTapOnBagItem(id: Int) {
        
        guard let productIDs = interactor?.productID(for: id) else {
            print("Unable to fetch product ids for \(id)")
            return
        }
        
        router?.navigateToProductDetail(productId: productIDs.productId, externalId: productIDs.externalProductId)
    }
    
    public func updateWishlistStatus(id: Int, isWishlisted: Bool) {
        
        interactor?.updateWishlistStatus(id: id, isWishlisted: isWishlisted)
    }
}
