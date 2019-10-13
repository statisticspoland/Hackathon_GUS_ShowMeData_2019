//
//  AnswerSelectorView.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit


private let padding: CGFloat = CGFloat(32.0)
private let spacing: CGFloat = CGFloat(18.0)


protocol AnswerSelectorViewDelegate: class {
    func answerSelectorView(_ view: AnswerSelectorView, didSelect index: Int)
}

/// View that allows select answer for question
/// It must be TOP view in hierarchy
/// .
/// Widok przeznaczony do zaznaczania pytania
/// musi myć na szczycie widoków w hierarchi
class AnswerSelectorView: BasicView, UIGestureRecognizerDelegate {
    weak var delegate: AnswerSelectorViewDelegate?
    
    /// button used only for height calculation
    /// .
    /// fikcyjny guzik używany do licenia wysokości
    private let fakeBtn: AnswerSelectorViewButton = {
        () -> AnswerSelectorViewButton in
        let fakeBtn: AnswerSelectorViewButton = AnswerSelectorViewButton()
        fakeBtn.display(text: "asd", color: UIColor.black)
        return fakeBtn
    }()
    
    private var buttons: [AnswerSelectorViewButton] = [] {
        willSet {
            for btn in buttons {
                btn.removeFromSuperview()
            }
        }
        didSet {
            for (i, btn) in buttons.enumerated() {
                btn.tag = i
                addSubview(btn)
                btn.addTarget(
                    self,
                    action: #selector(didTap(btn:)),
                    for: UIControl.Event.touchUpInside
                )
                let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(
                    target: self,
                    action: #selector(didDrag(gesture:))
                )
                pan.delegate = self
                btn.addGestureRecognizer(pan)
            }
        }
    }
    
    override func initialize() {
        super.initialize()
        
        backgroundColor = UIColor.clear
    }
    
    /// answer may be selected by tapping it od draging into this view
    /// .
    /// odpowiedź może być zaznaczona przez kliknięcie jak i przesunięcie w obszar tego widoku
    var goalView: UIView?
    
    /// display possible answers, color is used for border color
    /// .
    /// Wyświetla pytania, kolor jest użyty do obramowania
    func display(answers: [(String, UIColor)]) {
        buttons = answers.map {
            (x) -> AnswerSelectorViewButton in
            let btn: AnswerSelectorViewButton = AnswerSelectorViewButton()
            btn.display(text: x.0, color: x.1)
            return btn
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contentW: CGFloat = bounds.width - CGFloat(2.0) * padding
        let spacingW: CGFloat = CGFloat(max(0, buttons.count - 1)) * spacing
        let btnW: CGFloat = (contentW - spacingW) / CGFloat(buttons.count)
        
        var x: CGFloat = padding
        
        for btn in buttons {
            btn.frame = CGRect(
                x: x, y: CGFloat(0.0),
                width: btnW, height: bounds.height
            )
            x += btnW + spacing
        }
    }
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(
            width: UIView.noIntrinsicMetric,
            height: fakeBtn.intrinsicContentSize.height
        )
    }
    
    
    @objc private func didTap(btn: AnswerSelectorViewButton) {
        
        UIView.animate(
            withDuration: 0.6,
            animations: {
                guard self.goalView != nil else { return }
                btn.center = self.goalView!.center
            },
            completion: {
                (_: Bool) in
                self.delegate?.answerSelectorView(self, didSelect: btn.tag)
            }
        )
    }
    
    
    private var initialFrame: CGRect?
    
    @objc private func didDrag(gesture: UIPanGestureRecognizer) {
        guard let view: UIView = gesture.view else { return }
        bringSubviewToFront(view)
        switch gesture.state {
        case .began:
            initialFrame = gesture.view?.frame
        case .changed:
            guard let initialFrame: CGRect = initialFrame else { return }
            let translation = gesture.translation(in: self)
            view.frame = CGRect(
                x: initialFrame.minX + translation.x,
                y: initialFrame.minY + translation.y,
                width: initialFrame.width,
                height: initialFrame.height
            )
        case .ended:
            let _goalFrame: CGRect? = goalView?.convert(
                goalView!.bounds, to: self
            )
            guard let goalFrame: CGRect = _goalFrame else { return }
            
            let hitFrame: CGRect = goalFrame.inset(
                by: UIEdgeInsets(
                    top: CGFloat(90.0), left: CGFloat(90.0),
                    bottom: CGFloat(90.0), right: CGFloat(90.0)
                )
            )
            if view.frame.intersects(hitFrame) {
                delegate?.answerSelectorView(self, didSelect: view.tag)
            } else {
                UIView.animate(
                    withDuration: TimeInterval(0.6),
                    delay: TimeInterval(0.0),
                    usingSpringWithDamping: CGFloat(0.99),
                    initialSpringVelocity: CGFloat(0.3),
                    options: [
                        UIView.AnimationOptions.curveEaseIn
                    ],
                    animations: {
                        view.frame = self.initialFrame!
                    }
                )
            }
        default:
            setNeedsLayout()
        }
        
        
    }
    
    // MARK: UIGestureRecognizerDelegate
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        return goalView != nil
    }
    
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive press: UIPress
    ) -> Bool {
        return goalView != nil
    }
}
