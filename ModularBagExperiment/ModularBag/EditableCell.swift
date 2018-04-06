//
//  EditableCell.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 14/01/2018.
//

import Foundation

public protocol EditableCell {
    func setEditMode(to editing: Bool, animate: Bool)
}
