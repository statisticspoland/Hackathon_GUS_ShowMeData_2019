//
//  OnboardModel.swift
//  Gus2
//
//  Created by Tomasz Lizer on 15/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation

/// Struct that contains data with dialog strings
///
/// Use this struct, to construct dialogs in the onboard screen
struct ConversationItem {
    let bubble: String
    let button: String
}


class OnboardModel {
    
    var dialog: [ConversationItem] { return _dialog }
    private var _dialog: [ConversationItem] = [
        ConversationItem.init(bubble: "Potrzebuję twojej pomocy. Borykam się z licznymi problemami. Pomożesz mi?", button: "Oczywiście!")
    ]
    
    /// Use this function to fetch subsequent elements of conversation
    ///
    /// Each use of this function reduce dialog array. When array is empty,
    /// then nextItem returns nil and you should end conversation
    func nextItem() -> ConversationItem? {
        if let item = _dialog.first {
            _dialog = Array(_dialog.dropFirst())
            return item
        }
        return nil
    }
    
}
