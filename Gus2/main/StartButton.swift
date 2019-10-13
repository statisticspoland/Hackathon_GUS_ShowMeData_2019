//
//  StartButton.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 12/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit


class StartButton: BasicButton {
    override func initialize() {
        super.initialize()
        backgroundColor = UIColor.App.buttonColor
        setTitleColor(UIColor.white, for: .normal)
        titleLabel!.font = UIFont.boldSystemFont(ofSize: 24)
        contentEdgeInsets.left = CGFloat(20.0)
        contentEdgeInsets.right = CGFloat(20.0)
        contentEdgeInsets.bottom = CGFloat(12.0)
        contentEdgeInsets.top = CGFloat(12.0)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize.init(width: 3, height: 6)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / CGFloat(2.0)
    }
}

