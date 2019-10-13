//
//  MainCreditsButton.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 12/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit


class MainCreditsButton: BasicButton {
    
    var points: Int = 200 {
        didSet {
            setTitle("\(points)", for: UIControl.State.normal)
        }
    }
    
    override func initialize() {
        super.initialize()
        
        setImage(
            UIImage.App.simple_star.withRenderingMode(
                UIImage.RenderingMode.alwaysOriginal
            ),
            for: UIControl.State.normal
        )
        setTitleColor(UIColor.white, for: UIControl.State.normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        setTitle("\(points)", for: UIControl.State.normal)
        backgroundColor = UIColor.App.buttonColor
        contentEdgeInsets.left = CGFloat(20.0)
        contentEdgeInsets.right = CGFloat(14.0)
        contentEdgeInsets.bottom = CGFloat(12.0)
        contentEdgeInsets.top = CGFloat(12.0)
        imageEdgeInsets.left = CGFloat(-10.0)
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
