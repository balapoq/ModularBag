//
//  PoqClassicBagContentBlockBuilder.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 27/12/2017.
//

import Foundation

public class PoqClassicBagContentBlockBuilder: BagContentBlockBuilder {
    
    public func generateContentBlocks(_ model: [PoqBagItem]) -> [PoqModularBagViewData] {
        var content = [PoqModularBagViewData]()
        model.forEach() { bagItem in

            if let quantity = bagItem.quantity, quantity > 0 {
                var bagItemViewData = PoqPoqBagItemViewData()
                bagItemViewData.id = bagItem.id
                bagItemViewData.productTitle = bagItem.product?.title
                bagItemViewData.brandName = bagItem.product?.brand

                if let price = bagItem.product?.price {
                    bagItemViewData.price = Decimal(price)
                }

                if let specialPrice = bagItem.product?.specialPrice {
                    bagItemViewData.specialPrice = Decimal(specialPrice)
                }
                
                if let isWishlisted = bagItem.product?.isFavorite {
                    bagItemViewData.isWishlisted = isWishlisted
                }

                bagItemViewData.productImageUrl = bagItem.product?.thumbnailUrl

                if let subTotal = bagItem.subTotal {
                    bagItemViewData.subTotal = Decimal(subTotal)
                }

                bagItemViewData.quantity = bagItem.quantity

                let bagViewData = PoqModularBagViewData.bagItemCard(bagItem: bagItemViewData)
                content.append(bagViewData)
            }

        }

        return content
    }
    
    public func deleteBagItem(id: Int, from bag: [PoqBagItem]) -> [PoqBagItem] {
        
        guard let indexOfBagItem = bag.index(where: { $0.id == id }) else {
            print("Cannot find bag item with id \(id) in given bag. Cannot remove bag item.")
            return bag
        }
        
        var editedBag = bag
        editedBag[indexOfBagItem].quantity = 0
        
        return editedBag
    }
    
    public func updateQuantity(of bagItemId: Int, in bag: [PoqBagItem], to quantity: Int) -> [PoqBagItem] {
        
        var editedBag = bag
        
        guard let indexOfBagItem = editedBag.index(where: { $0.id == bagItemId }) else {
            print("Cannot find bag item with id \(bagItemId) in given bag. Cannot update quantity.")
            return bag
        }
        
        editedBag[indexOfBagItem].quantity = quantity
        
        return editedBag
    }
    
    public func bagTotal(for bag: [PoqBagItem]) -> Decimal {
        
        var total: Decimal = 0
        
        bag.forEach { bagItem in
            
            if let specialPrice = bagItem.product?.specialPrice {
                
                total += Decimal(specialPrice)
                
            } else if let price = bagItem.product?.price {
                
                total += Decimal(price)
            }
        }
        
        return total
    }
    
    public func numberOfItems(in bag: [PoqBagItem]) -> Int {
        
        return bag.count
    }
    
    public func productID(for bagItemId: Int, in bag: [PoqBagItem]) -> ProductID? {
        
        guard let bagItem = bag.first(where: { $0.id == bagItemId }) else {

            print("Unable to find bag item")
            return nil
        }
        
        guard let productId = bagItem.product?.id, let externalProductId = bagItem.product?.externalID else {
            print("BagItem does not have product or external Id")
            return nil
        }
        
        return ProductID(productId: productId, externalProductId: externalProductId)
    }
    
    public func product(for bagItemId: Int, in bag: [PoqBagItem]) -> PoqProduct? {
       
        guard let bagItem = bag.first(where: { $0.id == bagItemId }) else {
            
            print("Unable to find bag item")
            return nil
        }
        
        guard let product = bagItem.product else {
            print("Product is nil for bag item.")
            return nil
        }
        
        return product
    }
}
