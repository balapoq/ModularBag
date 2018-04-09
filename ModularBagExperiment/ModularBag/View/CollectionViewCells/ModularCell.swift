//
//  ModularCell.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 29/12/2017.
//

import Foundation

// The protocol to be adopted by all cells that are meant to be used in Modular Collection View Screens.
public protocol ModularCell {
    associatedtype ContentItem
    associatedtype DelegateType
    func setup(with contentItem: ContentItem, delegate: DelegateType?)
}

public protocol ModularBagItemCellPresenter: NSObjectProtocol {
    func deleteBagItem(id: Int)
    var inEditMode: Bool? { get }
    func updateQuantity(of bagItemId: Int, to quantity: Int)
    func didTapOnBagItem(id: Int)
    func updateWishlistStatus(id: Int, isWishlisted: Bool)
}
