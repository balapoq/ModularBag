//
//  ModularBagRouter.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 11/12/2017.
//

import Foundation

public protocol ModularBagRouter {
    func navigateToCheckout()
    func navigateToProductDetail(productId: Int, externalId: String)
}

