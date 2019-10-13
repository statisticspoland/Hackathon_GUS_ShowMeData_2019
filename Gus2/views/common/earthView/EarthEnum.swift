//
//  EarthEnum.swift
//  Gus2
//
//  Created by Tomasz Lizer on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


/// Enum containing all Earth styles
enum Earth {
    case cat
    case coolGlass
    case meh
    case sadConfused
    case sadClosedEyes
    case sadCry
    
    var image: UIImage {
        switch self {
        case .cat:
            return UIImage.App.earth_1
        case .coolGlass:
            return UIImage.App.earth_2
        case .meh:
            return UIImage.App.earth_3
        case .sadConfused:
            return UIImage.App.earth_4
        case .sadClosedEyes:
            return UIImage.App.earth_5
        case .sadCry:
            return UIImage.App.earth_6
        }
    }
    
    
    static func from(happiness: Int) -> Earth {
        switch happiness {
        case -3:
            return .sadCry
        case -2:
            return .sadClosedEyes
        case -1:
            return .sadConfused
        case 0:
            return .meh
        case 1:
            return .coolGlass
        case 2:
            return .cat
        default:
            if happiness < 0 {
                return .sadCry
            } else {
                return .cat
            }
        }
    }
}
