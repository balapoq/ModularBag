//
//  BagViewState.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 27/01/2018.
//

import Foundation

extension Bool {
    mutating func toggle() {
        self = !self
    }
}

public class BagViewState {
    
    public typealias BagViewStateHandler = (Action?) -> Void
    
    public enum Action {
        case changedEditMode
        case loading
        case scrolled
        case error(errorMessage: String)
    }
    
    private(set) var inEditMode = false
    
    public func toggleEditMode() {
        inEditMode.toggle()
        changeState(for: .changedEditMode)
    }
    
    
    public func loading() {
        
        changeState(for: .loading)
    }
    
    public func error(errorMessage: String) {
        
        changeState(for: .error(errorMessage: errorMessage))
    }
    
    fileprivate lazy var handlers = [BagViewStateHandler]()
    
    public func add(handler: @escaping BagViewStateHandler) {
      
        handlers.append(handler)
        
        // Call with initial empty/none state
        handler(nil)
    }
    
    func changeState(for action: Action) {
        print("StoreDebug ViewStateLog: Changing view state to \(action)")
        handlers.forEach { $0(action) }
    }
}
