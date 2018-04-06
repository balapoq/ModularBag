//
//  DataStore.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 07/02/2018.
//

import Foundation

public class DataStore<DataType> {
    public typealias ActionType = DataStore<DataType>.Action
    public typealias DataStoreActionHandler = (ActionType?) -> Void
    
    public enum Action {
        case set(data: DataType)
        case edit(data: DataType)
        case update(data: DataType?)
        case error(errorMessage: String)
    }
    
    fileprivate var data: DataType?
    
    fileprivate lazy var actionHandlers = [DataStoreActionHandler]()
    
    public func addHandler(_ actionHandler: @escaping DataStoreActionHandler) {
        
        actionHandlers.append(actionHandler)
        commitAction(nil)
    }
    
    public func commitAction(_ action: ActionType?) {
        print("StoreDebug DataStoreLog: action on DataStore - \(String(describing: action))")
        actionHandlers.forEach {
            
            $0(action)
        }
    }
    
    
    public func set(data: DataType) {
        
        self.data = data
        commitAction(.set(data: data))
    }
    
    public func edit(data: DataType) {
        
        self.data = data
        commitAction(.edit(data: data))
    }
    
    public func update() {
        
        commitAction(.update(data: data))
    }
    
    public func error(errorMessage: String) {
        
        commitAction(.error(errorMessage: errorMessage))
    }
}
