//
//  ContentBlockBuilder.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 03/01/2018.
//

import Foundation

public protocol ContentBlockBuilder {
    associatedtype DataModelType
    associatedtype ContentBlockType
    func generateContentBlocks(_ model: DataModelType) -> [ContentBlockType]
}

public protocol BagContentBlockBuilder: ContentBlockBuilder {
    
    associatedtype ProductType
    
    func deleteBagItem(id: Int, from bag: DataModelType) -> DataModelType
    func updateQuantity(of bagItemId: Int, in bag: DataModelType, to quantity: Int) -> DataModelType
    func bagTotal(for bag: DataModelType) -> Decimal
    func numberOfItems(in bag: DataModelType) -> Int
    func productID(for bagItemId: Int, in bag: DataModelType) -> ProductID?
    func product(for bagItemId: Int, in bag: DataModelType) -> ProductType?
}
