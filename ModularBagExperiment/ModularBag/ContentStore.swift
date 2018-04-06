//
//  ContentStore
//  PoqPlatform
//
//  Created by Balaji Reddy on 28/01/2018.
//

import Foundation

public class ContentStore<ContentType> {
    
    public typealias ContentStoreActionHandler = (ContentStore<ContentType>.Action?, [ContentType]?) -> Void
    
    public enum Action {
        case set(content: [ContentType])
        case edit(content: [ContentType])
        case deleted(indices: [Int], newContent: [ContentType])
        case update(content: [ContentType])
        case errorFetching
    }
    
    private(set) var content: [ContentType]?
    
    fileprivate var editedContent: [ContentType]?
    
    fileprivate lazy var actionHandlers = [ContentStoreActionHandler]()
    
    public func addHandler(_ actionHandler: @escaping ContentStoreActionHandler) {
        
        actionHandlers.append(actionHandler)
        commitAction(nil)
    }
    
    public func commitAction(_ action: ContentStore<ContentType>.Action?) {
        print("StoreDebug ContentStoreLog: action on ContentStore - \(String(describing: action))")
        actionHandlers.forEach {
            
            $0(action, content)
        }
    }
    
    public func deletedItems(at indices: [Int]) {
    
        indices.forEach() {
            content?.remove(at: $0)
        }
        
        commitAction(.deleted(indices: indices, newContent: content ?? []))
    }

    public func set(content: [ContentType]) {
    
        self.content = content
        commitAction(.set(content: content))
    }
    
    public func edited(content: [ContentType]) {
        
        self.content = content
        commitAction(.edit(content: content))
    }
    public  func update(content: [ContentType]) {
        
        self.content = content
        commitAction(.update(content: content))
    }
}
