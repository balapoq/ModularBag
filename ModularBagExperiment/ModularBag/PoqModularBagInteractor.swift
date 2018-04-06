//
//  PoqModularBagInteractor.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 03/01/2018.
//

import Foundation

public class PoqModularBagInteractor: ModularBagInteractor {
    
    public typealias ContentType = PoqModularBagViewData
    public typealias BagType = [PoqBagItem]
    public typealias DataStoreType = DataStore<BagType>
    public typealias DataStoreActionType = DataStoreType.Action
    public typealias ContentStoreType = ContentStore<PoqModularBagViewData>
    public typealias ContentStoreActionType = ContentStore<PoqModularBagViewData>.Action
    
    public init() {
        
    }
    
    public func initStore() {
        
        if dataStore == nil {
            
            dataStore = DataStoreType()
            dataStore?.addHandler(dataHandler)
        }
        
        if contentStore == nil {
            contentStore = ContentStoreType()
        }
    }
    
    public var dataManager: ModularBagDataManager?
    public var contentBlockBuilder: PoqClassicBagContentBlockBuilder?
    private var dataStore: DataStoreType?
    private var contentStore: ContentStoreType?
    
    private var bag: BagType? {
        
        return dataStore?.data
    }
    
    private var content: [ContentType]? {
        
        return contentStore?.content
    }
    
    fileprivate func addDataHandler(_ handler: @escaping (DataStoreActionType?) -> Void) {
        
        dataStore?.addHandler(handler)
    }
    
    public func addContentHandler(_ handler: @escaping (ContentStoreActionType?, [ContentType]?) -> Void) {
        
        contentStore?.addHandler(handler)
        
        if dataStore?.data == nil {
            fetchBag()
        }
    }
    
    public var bagTotal: Decimal? {
        
        guard let bag = bag else {
            
            assertionFailure("Bag is nil. Cannot provide bag total.")
            return 0.0
        }
        
        return contentBlockBuilder?.bagTotal(for: bag)
    }
    
    public var numberOfItems: Int? {
        
        guard let bag = bag else {
            
            assertionFailure("Bag is nil. Cannot provide number of item.")
            return 0
        }
        
        return contentBlockBuilder?.numberOfItems(in: bag)
    }
    
    public func deleteBagItem(id: Int) {
        
        guard let bag = bag else {
            
            print("Bag is nil. Cannot delete item from bag")
            return
        }
        
        guard let editedBag = contentBlockBuilder?.deleteBagItem(id: id, from: bag) else {
            
            print("Could not build bag. ContentBlockBuilder is nil")
            return
        }
        
        dataStore?.edit(data: editedBag)
    }
    
    public func productID(for bagItemId: Int) -> ProductID? {
        
        guard let bag = bag else {
            
            print("Bag is nil. Cannot fetch product Ids.")
            return nil
        }
        
        return contentBlockBuilder?.productID(for: bagItemId, in: bag)
    }
    
    public func updateQuantity(of bagItemId: Int, to quantity: Int) {
        
        guard let bag = bag else {
            
            print("Bag is nil. Cannot delete item from bag")
            return
        }
        
        guard let editedBag = contentBlockBuilder?.updateQuantity(of: bagItemId, in: bag, to: quantity) else {
            
            print("Could not build bag. ContentBlockBuilder is nil")
            return
        }
        
        dataStore?.edit(data: editedBag)
    }
    
    public func updateBag() {
        
        dataStore?.update()
    }
    
    public func updateWishlistStatus(id: Int, isWishlisted: Bool) {
        
        guard let bag = bag else {
            
            print("Bag is nil. Cannot add to wishlist")
            return
        }
        
        // ToDo: Change wishlist helper to accept Product protocol and change cast
        guard let product = contentBlockBuilder?.product(for: id, in: bag) as? ModularProduct else {
        
            print("Product is nil. Cannot add to wishlist")
            return
        }
        
        if isWishlisted {
            
           // WishlistHelper.sharedInstance.add(product)
        } else if let productId = product.id {
            
          //  WishlistHelper.sharedInstance.remove(productId)
        }
    }
    
    func dataHandler(action: DataStoreActionType?) {
        
        switch action {
            
        case .none:
            
            break
            
        case .set(let bag)?:
            
            guard let content = contentBlockBuilder?.generateContentBlocks(bag) else {
                print("Unable to generate content from bag")
                return
            }
            
          //  BadgeHelper.setBadge(for: Int(AppSettings.sharedInstance.shoppingBagTabIndex), value: contentBlockBuilder?.numberOfItems(in: bag) ?? 0)
            contentStore?.set(content: content)
            
        case .edit(let bag)?:
            
            guard let content = contentBlockBuilder?.generateContentBlocks(bag) else {
                print("Unable to generate content from bag")
                return
            }
            
            guard let contentUnwrapped = self.content else {
                print("Content is nil. Cannot edit it.")
                return
            }
            
            let deletedIndices = contentUnwrapped.enumerated().filter {
                content.index(of: $1) == nil
                }.map { $0.0 }
            
            if !deletedIndices.isEmpty {
                
                contentStore?.deletedItems(at: deletedIndices)
            } else {
                
                contentStore?.edited(content: content)
            }
            
        case .update(let bag)?:
            
            guard let bagUnwrapped = bag else {
                print("Cannot update bag. Nil bag received from data store")
                return
            }
            dataManager?.updateBag(bagUnwrapped, callOnCompletion: { _ in self.fetchBag() }, callOnFailure: { error in self.dataStore?.error(errorMessage: error?.localizedDescription ?? "Unknown error while updating data.") })
            
        default:
            
            return
        }
    }
    
    public func fetchBag() {

        dataManager?.fetchBag(callOnCompletion: { bag in self.dataStore?.set(data: bag) }, callOnFailure: { error in self.dataStore?.error(errorMessage:
            error?.localizedDescription ?? "Unknown error while fetching Bag") })
    }
    
    public func fetchBag(callOnCompletion completion: @escaping ([ContentType]) -> Void, callOnFailure failure: @escaping (Error?) -> Void) {
        
        dataManager?.fetchBag(callOnCompletion: { [weak self] bag in
            if let content = self?.contentBlockBuilder?.generateContentBlocks(bag) {
                completion(content)
            }
            }, callOnFailure: failure)
    }
    
    public func updateBag(callOnCompletion completion: @escaping ([ContentType]) -> Void, callOnFailure failure: @escaping (Error?) -> Void) {
        
        dataManager?.fetchBag(callOnCompletion: { [weak self] bag in
            if let content = self?.contentBlockBuilder?.generateContentBlocks(bag) {
                completion(content)
            }
            }, callOnFailure: failure)
    }
    
}
