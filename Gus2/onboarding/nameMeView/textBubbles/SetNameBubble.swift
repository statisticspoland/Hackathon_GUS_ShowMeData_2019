//
//  SetNameBubble.swift
//  Gus2
//
//  Created by Tomasz Lizer on 12/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit

private let earthTalkViewFont: UIFont = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
private let padding: UIEdgeInsets = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
private let borderWidth: CGFloat = 5
private let cornerRadius: CGFloat = 30


protocol SetNameBubbleDelegate: class {
    func setNameBubble(didEntered name: String)
}


/// This class is used to display button in which user sets Earth name.
class SetNameBubble: BasicView, UITextFieldDelegate {
    
    weak var delegate: SetNameBubbleDelegate?
    
    private let arrow: UIImageView = UIImageView.init(image: #imageLiteral(resourceName: "BubbleArrow"))
    private let wrapper: UIView = {
        let view: UIView = UIView()
        return view
    }()
    private let helloLabel: UILabel = {
        let lbl: UILabel = UILabel()
        lbl.font = earthTalkViewFont
        lbl.text = "Cześć! Nazywam"
        lbl.numberOfLines = 0
        return lbl
    }()
    private let helloLabel2: UILabel = {
        let lbl: UILabel = UILabel()
        lbl.font = earthTalkViewFont
        lbl.text = "się: "
        return lbl
    }()
    private let nameTextField: UITextField = {
        let txtField: UITextField = UITextField()
        txtField.font = earthTalkViewFont
        txtField.keyboardType = UIKeyboardType.alphabet
        txtField.borderStyle = UITextField.BorderStyle.none
        return txtField
    }()
    private let nameUnderline: CALayer = CALayer()
    /// Use this to set maximum wodth that you wish the bubble should have.
    /// It is neede for size calculation.
    var preferredMaxLayoutWidth: CGFloat = 0 {
        didSet {
            guard oldValue != preferredMaxLayoutWidth else { return }
            let prefW: CGFloat = preferredMaxLayoutWidth - padding.left - padding.right
            helloLabel.preferredMaxLayoutWidth = prefW
        }
    }
    
    
    override func initialize() {
        super.initialize()
        
        self.addSubview(wrapper)
        self.addSubview(arrow)
        wrapper.addSubview(helloLabel)
        wrapper.addSubview(helloLabel2)
        wrapper.addSubview(nameTextField)
        
        nameTextField.delegate = self
        nameTextField.layer.addSublayer(nameUnderline)
        nameUnderline.backgroundColor = UIColor.black.cgColor
        
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
        
        helloLabel.frame = CGRect.init(
            x: padding.left, y: padding.top,
            width: lblW,
            height: helloLabel.intrinsicContentSize.height
        )
        
        let hello2S: CGSize = helloLabel2.intrinsicContentSize
        helloLabel2.frame = CGRect.init(
            x: padding.left, y: helloLabel.frame.maxY,
            width: hello2S.width,
            height: hello2S.height
        )
        
        
        nameTextField.frame = CGRect.init(
            x: padding.left + hello2S.width,
            y: helloLabel.frame.maxY,
            width: lblW - hello2S.width,
            height: nameTextField.intrinsicContentSize.height
        )
        nameUnderline.frame = CGRect.init(
            x: 0, y: nameTextField.frame.height,
            width: nameTextField.frame.width, height: 1
        )
        
        arrow.frame.origin.x = cornerRadius
        arrow.frame.origin.y = self.bounds.height - borderWidth
    }
    
    
    override var intrinsicContentSize: CGSize {
        var contentS: CGSize = helloLabel.intrinsicContentSize
        contentS.height += padding.top + padding.bottom
        contentS.height += nameTextField.intrinsicContentSize.height
        contentS.width += padding.left + padding.right
        return contentS
    }
    
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let name = textField.text else { return false }
        guard !name.isEmpty else { return false }
        textField.resignFirstResponder()
        delegate?.setNameBubble(didEntered: name)
        return true
    }
    
    
}

