//
//  PoqModularBagViewDataType.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 15/12/2017.
//

import Foundation

public enum PoqModularBagViewData {
    case bagItemCard(bagItem: PoqBagItemViewData)
    case link(linkTitle: String, linkUrl: String)
}

extension PoqModularBagViewData: Equatable {
   
    public static func == (lhs: PoqModularBagViewData, rhs: PoqModularBagViewData) -> Bool {
        
        switch lhs {
        
        case .bagItemCard(let bagItem):
            if case .bagItemCard(let rhsBagItem) = rhs {
                
                return bagItem.id == rhsBagItem.id
            }
            return false
            
        case .link(let linkTitle, let linkUrl):
            
            if case .link(let rhsLinkTitle, let rhsLinkUrl) = rhs {
                return (linkTitle == rhsLinkTitle) && (linkUrl == rhsLinkUrl)
            }
            return false
        }
        
        return false
    }
}

public protocol PoqBagItemViewData {
    var id: Int? { get set }
    var productTitle: String? { get set }
    var brandName: String? { get set }
    var quantity: Int? { get set }
    var price: Decimal? { get set }
    var specialPrice: Decimal? { get set }
    var subTotal: Decimal? { get set }
    var productImageUrl: String? { get set }
    var isWishlisted: Bool? { get set }
}

public struct PoqPoqBagItemViewData: PoqBagItemViewData {
    public var id: Int?
    public var productTitle: String?
    public var brandName: String?
    public var quantity: Int?
    public var price: Decimal?
    public var specialPrice: Decimal?
    public var subTotal: Decimal?
    public var productImageUrl: String?
    public var isWishlisted: Bool?
    
    public init() {
        
    }
}

public struct PoqOrderSummaryViewData {
   public var total: Decimal
   public var numberOfItems: Int
}
