//
//  NameMeView.swift
//  Gus2
//
//  Created by Tomasz Lizer on 12/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


protocol NameMeViewDelegate: class {
    func nameMeView(didEntered name: String)
    func nameMeView(didTappedOk view: NameMeView)
}

/// Main view of nameMeViewController
class NameMeView: BasicView, SetNameBubbleDelegate {
    
    weak var delegate: NameMeViewDelegate?
    
    private let earthView: EarthView = EarthView(.cat)
    private let nameView: SetNameBubble = SetNameBubble()
    private let textBubble: TextBubbleView = TextBubbleView()
    private var okButton: StartButton = StartButton() 
    
    override func initialize() {
        super.initialize()
        
        self.backgroundColor = UIColor.App.backgroundColor
        
        self.addSubview(earthView)
        self.addSubview(nameView)
        self.addSubview(okButton)
        self.addSubview(textBubble)
        
        nameView.delegate = self
        
        okButton.isHidden = true
        textBubble.isHidden = true
        
        okButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    /// Displays subsequent elemnts of conversation with Earth.
    ///
    /// You should call changeBubbles() before using this function.
    func conversation(_ conversation: ConversationItem) {
        animate(
            duration: 0.3,
            changes: {
                self.textBubble.layer.opacity = 0.0
                self.setNeedsLayout()
                self.layoutIfNeeded()
            },
            completion: { completed in
                self.okButton.isHidden = false
                self.textBubble.display(text: conversation.bubble)
                self.animate(duration: 0.3, changes: {
                    self.okButton.setTitle(conversation.button, for: .normal)
                    self.textBubble.layer.opacity = 1.0
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                })
            }
        )
        animateHappyEarth(completion: nil)
    }
    
    
    private func animate(duration: TimeInterval, changes: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: duration,
            animations: {
                changes?()
            },
            completion: completion
        )
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let earthS: CGFloat = 300
        earthView.frame = CGRect.init(
            x: (self.bounds.width - earthS) / 2.0,
            y: (self.bounds.height - earthS) / 2.0,
            width: earthS,
            height: earthS
        )
        
        nameView.preferredMaxLayoutWidth = self.bounds.width - 40
        let nameViewS: CGSize = nameView.intrinsicContentSize
        nameView.frame = CGRect.init(
            x: 20, y: earthView.frame.origin.y - nameViewS.height - 20,
            width: nameViewS.width,
            height: nameViewS.height
        )
        
        textBubble.preferredMaxLayoutWidth = self.bounds.width - 40
        let buubleS: CGSize = textBubble.intrinsicContentSize
        textBubble.frame = CGRect.init(
            x: 20, y: earthView.frame.origin.y - buubleS.height - 20,
            width: buubleS.width,
            height: buubleS.height
        )
        
        let okS: CGSize = okButton.intrinsicContentSize
        okButton.frame = CGRect.init(
            x: (self.bounds.width - okS.width) / 2.0,
            y: self.bounds.height - okS.height - 50,
            width: okS.width,
            height: okS.height
        )
    }
    
    // MARK: - Private
    // function that animates Earth quick jumps. Used in between displaying conversation item.
    private func animateHappyEarth(completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(
            withDuration: 1, delay: 0.0,
            usingSpringWithDamping: 0.1,
            initialSpringVelocity: 3,
            options: [AnimationOptions.curveEaseInOut],
            animations: {
                self.earthView.transform = self.earthView.transform.translatedBy(x: 0, y: 40)
            },
            completion: { completed in
                completion?(completed)
            }
        )
    }
    
    
    /// Call this function after user succesfully enters name of Earth.
    ///
    /// This function changes displayed bubble from one with text field, to the one with just label.
    /// You then use this second bubble in conjunction with conversation(:) function.
    func changeBubbles(_ conversation: ConversationItem) {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.nameView.layer.opacity = 0.1
            },
            completion: {completed in
                self.nameView.isHidden = true
                self.textBubble.layer.opacity = 0.0
                self.textBubble.isHidden = false
                self.conversation(conversation)
            }
        )
    }
    
    
    @objc private func handleTap() {
        delegate?.nameMeView(didTappedOk: self)
    }
    
    // MARK: - SetNameBubbleDelegate
    func setNameBubble(didEntered name: String) {
        delegate?.nameMeView(didEntered: name)
    }
    
}
