//
//  AnswerSelectorViewButton.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit


/// Button for question answer
/// ,
/// Guzik używany do wyświetlania odpowiedzi na pytanie
class AnswerSelectorViewButton: BasicButton {
    override func initialize() {
        super.initialize()
        setTitleColor(UIColor.black, for: UIControl.State.normal)
        titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(20.0))
        backgroundColor = UIColor.white
        contentEdgeInsets.left = CGFloat(12.0)
        contentEdgeInsets.right = CGFloat(12.0)
        contentEdgeInsets.bottom = CGFloat(9.0)
        contentEdgeInsets.top = CGFloat(9.0)
        layer.borderWidth = CGFloat(5.0)
        layer.borderColor = UIColor.black.cgColor
    }
    
    func display(text: String, color: UIColor) {
        setTitle(text, for: UIControl.State.normal)
        layer.borderColor = color.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / CGFloat(2.0)
    }
}


