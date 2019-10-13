//
//  EarthCategory.swift
//  Gus2
//
//  Created by Tomasz Lizer on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


enum EarthCategory {
    case animals
    case plants
    case wind
    case water
    case rubbish
    
    var icon: UIImage {
        switch self {
        case .animals:
            return #imageLiteral(resourceName: "wolf-head")
        case .plants:
            return #imageLiteral(resourceName: "tree-silhouette")
        case .wind:
            return #imageLiteral(resourceName: "wind")
        case .water:
            return #imageLiteral(resourceName: "water-drop")
        case .rubbish:
            return #imageLiteral(resourceName: "recycling-bin")
        }
    }
    
}
