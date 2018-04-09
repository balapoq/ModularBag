//
//  ModularBagDataManager.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 11/12/2017.
//

import Foundation

public protocol ModularBagDataManager {

    typealias BagFetchCompletion = ([PoqBagItem]) -> Void
    typealias BagFetchFailure = (Error?) -> Void
    
    func fetchBag(callOnCompletion completion: @escaping BagFetchCompletion, callOnFailure failure: @escaping BagFetchFailure)
    
    func updateBag(_ bag: [PoqBagItem], callOnCompletion completion: @escaping BagFetchCompletion, callOnFailure failure: @escaping BagFetchFailure)
}
