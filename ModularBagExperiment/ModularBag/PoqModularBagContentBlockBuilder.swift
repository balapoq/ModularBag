//
//  PoqModularBagContentBlockBuilder.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 27/12/2017.
//

//class PoqModularBagContentBlockBuilder<BagType: ModularBag>: BagContentBlockBuilder {
//
//    func generateContentBlocks(_ model: BagType) -> [PoqModularBagViewData] {
//        var content = [PoqModularBagViewData]()
//        model.bagItems?.forEach() { bagItem in
//
//            var bagItemViewData = PoqPoqBagItemViewData()
//            bagItemViewData.id = bagItem.id
//            bagItemViewData.productTitle = bagItem.product?.title
//            bagItemViewData.brandName = bagItem.product?.brand
//
//            if let price = bagItem.product?.price {
//                bagItemViewData.price = Decimal(price)
//            }
//
//            if let specialPrice = bagItem.product?.specialPrice {
//                bagItemViewData.specialPrice = Decimal(specialPrice)
//            }
//
//            bagItemViewData.productImageUrl = bagItem.product?.thumbnailUrl
//
//            if let subTotal = bagItem.subTotal {
//                bagItemViewData.subTotal = Decimal(subTotal)
//            }
//
//            bagItemViewData.quantity = bagItem.quantity
//
//            let bagViewData = PoqModularBagViewData.bagItemCard(bagItem: bagItemViewData)
//            content.append(bagViewData)
//
//        }
//
//        return content
//    }
//
//    // ToDo: Finish this implementation
//    func deleteBagItem(id: Int, from bag: BagType) -> BagType {
//
//        return bag
//    }
//
//    // ToDo: Finish this implementation
//    func updateQuantity(of bagItemId: Int, in bag: BagType, to quantity: Int) -> BagType {
//
//        return bag
//    }
//
//    // ToDo: Finish this implementation
//    func numberOfItems(in bag: BagType) -> Int {
//        return 0
//    }
//
//
//    // ToDo: Finish this implementation
//    func bagTotal(for bag: BagType) -> Decimal {
//
//        return 0.0
//    }
//
//    // ToDo: Finish this implementation
//    func productID(for bagItemId: Int, in bag: BagType) -> ProductID? {
//
//        return nil
//    }
//
//
//    // ToDo: Finish this implementation
//    func product(for bagItemId: Int, in bag: BagType) -> BagType.BagItemType.ProductType? {
//
//        return nil
//    }
//}
