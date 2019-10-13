//
//  QuestionImageView.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit


/// Image view for displaing question chart
/// .
/// Widok wyświetlający wykres na ekranie pytania
class QuestionImageView: UIImageView {
    
    var preferredMaxLayoutWidth: CGFloat = CGFloat(0.0) {
        didSet {
            guard preferredMaxLayoutWidth != oldValue else { return }
            invalidateIntrinsicContentSize()
        }
    }
    
    override var image: UIImage? {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        preferredMaxLayoutWidth = bounds.width
    }
    
    
    override var intrinsicContentSize: CGSize {
        let aspect: CGFloat
        if let image: UIImage = image {
            aspect = image.size.height / image.size.width
        } else {
            aspect = CGFloat(0.0)
        }
        let height: CGFloat = preferredMaxLayoutWidth * aspect
        return CGSize(
            width: UIView.noIntrinsicMetric,
            height: height
        )
    }
    
    
}
