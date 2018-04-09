//
//  PoqModularBag.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 17/12/2017.
//

import Foundation

public protocol ModularBag {

    var id: Int? { get set }
    var itemCount: Int? { get set }
    var total: Double? { get set }
    var bagItems: [ModularBagItem]? { get set }
    var merchandiseTotal: Double? { get set }
    var shippingSurcharge: Double? { get set }
    var estimatedShipping: Double? { get set }
}

public protocol ModularBagItem {
    var id: Int? { get }
    var productId: Int? { get }
    var quantity: Int? { get set }

    var priceOfOneItem: Double? { get }
    var surcharge: Double? { get }
    var subTotal: Double? { get }

    var product: ModularProduct? { get }

    var productSizeId: Int? { get }
}

public struct PoqBagItem: Codable {
    public var id:Int?
    public var productId: Int?
    public var quantity: Int?
    public var productSizeId: Int?
    public var appId: Int?
    public var poqUserId: String?
    public var product: PoqProduct?
    public var message: String?
    public var statusCode: Int?
    public var cartId: String? // Native checkout - magento enterprise only
    public var priceOfOneItem: Double?
    public var surcharge: Double?
    public var subTotal: Double?
    public var barcode: String?
    public var isRegistryItem: Bool?
    public var stockMessage: String?
    public var isGiftAvailable: Bool?
}

public protocol ModularProduct {

    var id: String? { get }
    var title: String? { get }
    var thumbnailUrl: String? { get }

    var productSizes: [ModularProductSize]? { get }

    var price: Double? { get }
    var specialPrice: Double? { get }
    var brand: String? { get }
    var isFavorite: Bool { get }
    var externalID: String { get set }
}

public struct PoqProduct: Codable {

    /// The id of the product
    public var id: Int?
    
    /// The title of the product
    public var title: String?
    
    /// The body of the product TODO: What do we use the body for?
    public var body: String?
    
    /// The description of the product
    public var description: String?
    
    /// The price of the product
    public var price: Double?
    
    /// The promotion or special price of the product
    public var specialPrice: Double?
    
    /// The video url of the product
    public var videoURL: String?
    
    /// The product's picture url
    public var pictureURL: String?
    
    /// The order index, used for sorting
    public var sortIndex: Int?
    
    /// The product's picture width
    public var pictureWidth: Int?
    
    /// The product's picture height
    public var pictureHeight: Int?
    
    /// The product's thumbnail url
    public var thumbnailUrl: String?
    
    /// The product's thumbnail width
    public var thumbnailWidth: Int?
    
    /// The product's thumbnail height
    public var thumbnailHeight: Int?
    
    /// Check to see if the product is favorited or not
    public var isFavorite: Bool?
    
    /// The number of likes the product has received
    public var numberofLikes: Int?
    
    /// The number of reviews the product has received
    public var numberOfReviews: Int?
    
    /// The related product ids. We use this to render a grouped list
    public var relatedProductIDs: [Int]?
    
    /// The bundle id of the product in case the product is actually a multi product
    public var bundleId: String?
    
    /// The product's sizes
    public var productSizes: [PoqProductSize]?

    
    /// The product's external. TODO: I rememeber a recomandation about this being needed in all product requests
    public  var externalID: String?
    
    /// The product's web url
    public  var productURL: String?
    
    /// The selected color of the product
    public  var color: String?
    
    /// TODO: We are not using this anywhere in the platform
    public  var colorGroupId: String?
    
    /// Check to see if the product has more color
    public  var hasMoreColors: Bool?
    
    /// The url of the color swatch
    public  var colorSwatchUrl: String?
    
    /// The product's brand
    public  var brand: String?
    
    /// The product's promotion text
    public  var promotion: String?
    
    /// The product's size guide - This doesn't seem to be used anywhere in the Platform
    public  var sizeGuide: String?
    
    /// TODO: This is not used anywhere in the platform
    public  var returns: String?
    
    /// TODO: Not used in the platform
    public  var delivery: String?
    
    /// TODO: Not used in the platform
    public  var style: String?
    
    /// TODO: Not used in the platform
    public  var rating: Double?
    
    /// Text displayed in the bag if international delivery is available
    public  var internationalDelivery: Bool?
    
    /// Text displayed in the bag if home delivery is available
    public  var homeDelivery: Bool?
    
    /// Text displayed in the bag if buy and collect is available
    public  var buyAndCollect: Bool?
    
    /// Displayed in the product availablity cell if the product is available in store or not
    public  var isAvailableInStore: Bool?
    
    /// The product's selected size id
    public  var selectedSizeID: Int?
    
    /// The product's selected size name
    public  var selectedSizeName: String?
    
    
    /// Wether or not the promotion text receives tap gestures. TODO: The naming is faulty we should rename this to something clearer
    public  var isBadge: Bool?
    
    /// The selected product's color id
    public  var selectedColorProductID: Int?
    
    /// Used to format the price by using createPriceLabelText method in LabelStyleHelper
    public  var priceRange: String?
    
    /// Used to format the special price by using createPriceLabelText method in LabelStyleHelper
    public  var specialPriceRange: String?
    
    /// TODO: This flag seems to be set from appsettings
    public  var isClearance: Bool?
    
    /// TODO: This is not used in the platform
    public  var reviewProductCode: String?
    
    /// The external ids of the related products
    public  var relatedExternalProductIDs: [String]?
    
    /// Check wether the product is in stock. We treat isInStock == nil as isInStock == true. TODO: The nil approach is faulty most devs will think nil is false
    public  var isInStock: Bool?
    
}

public protocol ModularProductSize {
    var id: Int? { get set }
    var size: String? { get set }
    var sku: String? { get set }
    var quantity: Int? { get set }
    var ean: String? { get set }
    var price: Double? { get set }
    var specialPrice: Double? { get set }
    var isClearance: Bool? { get set }
    var isLowStock: Bool? { get set }
}

public struct PoqProductSize: Codable {
    
    var id: Int?
    var size: String?
    var sku: String?
    var quantity: Int?
    var ean: String?
    var price: Double?
    var specialPrice: Double?
    var isClearance: Bool?
    var isLowStock: Bool?
}
