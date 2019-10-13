//
//  BasicControll.swift
//  Gus2
//
//  Created by Tomasz Lizer on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


class BasicControll: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    
    /// Function fired once in every init()
    func initialize() {}
    
    
}
