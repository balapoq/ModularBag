//
//  PoqModularBagDataManager.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 03/01/2018.
//

import Foundation

//class PoqModularBagDataManager<PoqBagType: ModularBag>: ModularBagDataManager, PoqNetworkTaskDelegate {
//    
//    var callOnBagFetchCompletion: BagFetchCompletion?
//    var callOnBagFetchFailure: BagFetchFailure?
//    
//    var callOnUpdateBagCompletion: BagFetchCompletion?
//    var callOnUpdateBagFailure: BagFetchFailure?
//    
//    
//    /**
//     Callback after async network task is completed successfully
//     */
//    func networkTaskDidComplete(_ networkTaskType: PoqNetworkTaskTypeProvider, result: [Any]?) {
//        switch networkTaskType {
//            
//        case PoqNetworkTaskType.getModularBag:
//            parseBagFetch(result as? [PoqBagType])
//            
//        case PoqNetworkTaskType.postBag:
//            parseBagUpdate(result as? [PoqBagType])
//            
//        default:
//            print("Network task is not implemented:\(networkTaskType)")
//        }
//    }
//    
//    
//    public func parseBagFetch(_ result: [PoqBagType]?) {
//        guard let bags = result, bags.count == 1 else {
//            print("No bag or more than one bags present for user")
//            let error = NSError(domain: "", code: 404, userInfo: nil)
//            callOnBagFetchFailure?(error)
//            return
//        }
//        
//        callOnBagFetchCompletion?(bags[0])
//    }
//    
//    
//    public func parseBagUpdate(_ result: [PoqBagType]?) {
//        guard let bags = result, bags.count == 1 else {
//            print("No bag or more than one bags present for user")
//            let error = NSError(domain: "", code: 404, userInfo: nil)
//            callOnUpdateBagFailure?(error)
//            return
//        }
//        
//        callOnUpdateBagCompletion?(bags[0])
//    }
//    
//    
//    /**
//     Callback when task fails due to lack of responded data, connectivity etc.
//     */
//    func networkTaskDidFail(_ networkTaskType: PoqNetworkTaskTypeProvider, error: NSError?) {
//        
//        switch networkTaskType {
//            
//        case PoqNetworkTaskType.getModularBag:
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
//    
//    
//    
//    func fetchBag(callOnCompletion completion: @escaping (PoqBagType) -> Void, callOnFailure failure: @escaping (Error?) -> Void) {
//        
//        callOnBagFetchCompletion = completion
//        callOnBagFetchFailure = failure
//        
//        PoqNetworkService(networkTaskDelegate: self).getBag()
//        
//    }
//    
//    
//    func updateBag(_ bag: PoqBagType, callOnCompletion completion: @escaping (PoqBagType) -> Void, callOnFailure failure: @escaping (Error?) -> Void) {
//        
//        callOnUpdateBagCompletion = completion
//        callOnUpdateBagFailure = failure
//        
//        
//        // To be implemented
//        //PoqNetworkService(networkTaskDelegate: self).updateBag(bag)
//        
//    }
//    
//}
