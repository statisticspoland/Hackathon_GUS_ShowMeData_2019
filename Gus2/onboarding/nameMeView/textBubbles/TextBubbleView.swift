//
//  TextBubbleView.swift
//  Gus2
//
//  Created by Tomasz Lizer on 12/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


private let font: UIFont = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.bold)
private let padding: UIEdgeInsets = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
private let borderWidth: CGFloat = 5
private let cornerRadius: CGFloat = 30


/// Enum containing Text bubble arrow style
enum ArrowPlace {
    case bottom
    case left
    
    var arrow: UIImage {
        switch self {
        case .bottom:
            return #imageLiteral(resourceName: "BubbleArrow")
        case .left:
            return #imageLiteral(resourceName: "ArrowLeft")
        }
    }
}


/// Class that displays text bubble.
/// You can set arrow style (ArrowPlace) that changes appereance of the bubble.
/// ArrowPlace.bottom displays arrow at the bottom of the text bubble.
/// ArrowPlace.left displays arrow on the left side of the bubble.
class TextBubbleView: BasicView {
    
    
    private lazy var arrow: UIImageView = UIImageView(image: arrowPlace.arrow)
    private var arrowPlace: ArrowPlace = ArrowPlace.bottom {
        didSet {
            arrow.image = arrowPlace.arrow
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    private let wrapper: UIView = {
        let view: UIView = UIView()
        return view
    }()
    private let textLbl: UILabel = {
        let lbl: UILabel = UILabel()
        lbl.font = font
        lbl.numberOfLines = 0
        return lbl
    }()
    /// Use this to set maximum wodth that you wish the bubble should have.
    /// It is neede for size calculation.
    var preferredMaxLayoutWidth: CGFloat = 0 {
        didSet {
            guard oldValue != preferredMaxLayoutWidth else { return }
            let prefW: CGFloat = preferredMaxLayoutWidth - padding.left - padding.right
            textLbl.preferredMaxLayoutWidth = prefW
            invalidateIntrinsicContentSize()
        }
    }
    
    
    func display(text: String?) {
        textLbl.text = text
        setNeedsLayout()
    }
    
    
    /// Use this function to configure bubble arrow appereance.
    func set(arrowPlace place: ArrowPlace) {
        self.arrowPlace = place
    }
    
    override func initialize() {
        super.initialize()
        
        self.backgroundColor = UIColor.clear
        
        self.addSubview(wrapper)
        self.addSubview(arrow)
        wrapper.addSubview(textLbl)
        
        wrapper.backgroundColor = UIColor.white
        
        wrapper.layer.borderColor = UIColor.black.cgColor
        wrapper.layer.borderWidth = borderWidth
        wrapper.layer.cornerRadius = cornerRadius
        
        wrapper.layer.shadowColor = UIColor.black.cgColor
        wrapper.layer.shadowOpacity = 0.4
        wrapper.layer.shadowRadius = 10
        wrapper.layer.shadowOffset = CGSize.init(width: 3, height: 6)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        wrapper.frame = self.bounds
        
        let lblW: CGFloat = self.bounds.width - padding.left - padding.right
        
        textLbl.frame = CGRect.init(
            x: padding.left, y: padding.top,
            width: lblW,
            height: textLbl.intrinsicContentSize.height
        )
        
        
        switch arrowPlace {
        case .bottom:
            arrow.frame.origin.x = cornerRadius
            arrow.frame.origin.y = self.bounds.height - borderWidth
        case .left:
            arrow.frame.origin.x = borderWidth - arrow.bounds.width
            arrow.frame.origin.y = cornerRadius - 5
        }
        
    }
    
    
    override var intrinsicContentSize: CGSize {
        var contentS: CGSize = textLbl.intrinsicContentSize
        contentS.height += padding.top + padding.bottom
        contentS.width += padding.left + padding.right
        switch arrowPlace {
        case .bottom:
            break
        case .left:
            contentS.height = max(contentS.height, 90)
        }
        return contentS
    }
    
    
}
