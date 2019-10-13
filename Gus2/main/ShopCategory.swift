//
//  ShopCategory.swift
//  Gus2
//
//  Created by Mateusz Orzoł on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


/// Objects you can buy in the shop and set in the background of main screen
/// Objekty jakie można kupić w sklepie i ustawic jako tło na ekaranie głównym
enum ShopCategory {
    
    case none, castle, curtain, cat
    
    var title: String {
        switch self {
        case .none: return "Puste"
        case .castle: return "Zamek"
        case .curtain: return "Kurtyna"
        case .cat: return "Koteczek"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .none: return nil
        case .castle: return #imageLiteral(resourceName: "D48227CF-B4ED-4272-86B9-801CC79FD881")
        case .curtain: return #imageLiteral(resourceName: "28713400-9538-456C-A2C8-6FC229D0DA77")
        case .cat: return #imageLiteral(resourceName: "5F17EAAF-9A4B-469D-8F15-7956E2D07A9C")
        }
    }
    
    /// Price of the object
    /// Koszta przedmiotu
    var prive: Int {
        return 200
    }
}
