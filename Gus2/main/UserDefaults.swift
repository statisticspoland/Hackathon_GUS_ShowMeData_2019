//
//  UserDefaults.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation


private enum Key: String {
    case my_coins
    case my_happiness
    case all_coins
    case last_question
    case name
}

/// not used for presentation puproses
extension UserDefaults {
    var all_coins: Int {
        get { return integer(forKey: Key.all_coins.rawValue)}
        set {
//            set(newValue, forKey: Key.all_coins.rawValue)
//            synchronize()
        }
    }
    
    var my_coins: Int {
        get { return integer(forKey: Key.my_coins.rawValue)}
        set {
//            set(newValue, forKey: Key.my_coins.rawValue)
//            synchronize()
        }
    }
    
    var my_happiness: Int {
        get { return integer(forKey: Key.my_happiness.rawValue) }
        set {
//            set(newValue, forKey: Key.my_happiness.rawValue)
//            synchronize()
        }
    }
    
    var last_question: Int {
        get { return integer(forKey: Key.last_question.rawValue) }
        set {
//            set(newValue, forKey: Key.last_question.rawValue)
//            synchronize()
        }
    }
    
    var name: String? {
        get { return string(forKey: Key.name.rawValue) }
        set {
//            set(newValue, forKey: Key.name.rawValue)
//            synchronize()
        }
    }
}
