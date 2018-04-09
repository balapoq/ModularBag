//
//  PoqClassicBagDataManager.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 26/12/2017.
//

import Foundation

class PoqClassicBagDataManager: ModularBagDataManager {

    var callOnBagFetchCompletion: BagFetchCompletion?
    var callOnBagFetchFailure: BagFetchFailure?

    var callOnUpdateBagCompletion: BagFetchCompletion?
    var callOnUpdateBagFailure: BagFetchFailure?

//    /**
//     Callback after async network task is completed successfully
//     */
//    func networkTaskDidComplete(_ networkTaskType: PoqNetworkTaskTypeProvider, result: [Any]?) {
//        switch networkTaskType {
//
//        case PoqNetworkTaskType.getBag:
//            parseBagFetch(result as? [PoqBagItem])
//
//        case PoqNetworkTaskType.postBag:
//            parseBagUpdate(result as? [PoqMessage])
//
//        default:
//            print("Network task is not implemented:\(networkTaskType)")
//        }
//    }
//
//    public func parseBagFetch(_ result: [PoqBagItem]?) {
//        guard let bags = result else {
//            print("No bag or more than one bags present for user")
//            let error = NSError(domain: "", code: 404, userInfo: nil)
//            callOnBagFetchFailure?(error)
//            return
//        }
//
//        bags.enumerated().forEach { index, bagItem in
//
//            bags[index].product?.isFavorite = updateBagItemWishlistStatus(for: bagItem)
//
//        }
//
//        callOnBagFetchCompletion?(bags)
//    }
//
//    public func parseBagUpdate(_ result: [PoqMessage]?) {
//
////        guard let bags = result else {
////            print("No bag or more than one bags present for user")
////            let error = NSError(domain: "", code: 404, userInfo: nil)
////            callOnUpdateBagFailure?(error)
////            return
////        }
//
//        // Change this. Shouldn't be passing an empty array here. The call back must change.
//        callOnUpdateBagCompletion?([PoqBagItem]())
//    }
//
//    public func updateBagItemWishlistStatus(for bagItem: PoqBagItem) -> Bool {
//
//        guard let product = bagItem.product else {
//
//            return false
//        }
//
//        return WishlistHelper.sharedInstance.isProductWhishlisted(product)
//    }
//
//    /**
//     Callback when task fails due to lack of responded data, connectivity etc.
//     */
//    func networkTaskDidFail(_ networkTaskType: PoqNetworkTaskTypeProvider, error: NSError?) {
//
//        switch networkTaskType {
//
//        case PoqNetworkTaskType.getBag:
//
//            callOnBagFetchFailure?(error)
//
//        case PoqNetworkTaskType.postBag:
//
//            callOnUpdateBagFailure?(error)
//
//        default:
//            print("Network task is not implemented:\(networkTaskType)")
//        }
//    }

    func fetchBag(callOnCompletion completion: @escaping ([PoqBagItem]) -> Void, callOnFailure failure: @escaping (Error?) -> Void) {

        callOnBagFetchCompletion = completion
        callOnBagFetchFailure = failure

        
        
        guard let bagItemsFilePath = Bundle.main.path(forResource: "BagItems", ofType: "json"),
            let bagItemsFile = FileManager.default.contents(atPath: bagItemsFilePath) else {
            print("This didn't work well!")
            return
        }
        
        do {
            let bagItems = try JSONDecoder().decode(Array<PoqBagItem>.self, from: bagItemsFile)
            callOnBagFetchCompletion?(bagItems)
        } catch let error {
           print("\(error)")
        }
        
        
        
    //    PoqNetworkService(networkTaskDelegate: self).getUsersBagItems(User.getUserId())

    }

    func updateBag(_ bag: [PoqBagItem], callOnCompletion completion: @escaping ([PoqBagItem]) -> Void, callOnFailure failure: @escaping (Error?) -> Void) {

//        callOnUpdateBagCompletion = completion
//        callOnUpdateBagFailure = failure
//
//        let postBody = PoqBagItemPostBody()
//        bag.forEach { bagItem in
//
//            let postBodyItem = PoqBagItemPostBodyItem()
//            postBodyItem.id = bagItem.id
//            postBodyItem.quantity = bagItem.quantity
//            postBodyItem.productSizeID = bagItem.productSizeId
//            postBodyItem.sku = bagItem.product?.productSizes?[0].sku
//            postBodyItem.cartId = bagItem.cartId
//
//            postBody.items?.append(postBodyItem)
//        }
   
    //    PoqNetworkService(networkTaskDelegate: self).updateUsersBagItems(User.getUserId(), postBody: postBody)

    }
}
