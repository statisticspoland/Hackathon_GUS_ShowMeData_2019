//
//  FlatQuestionViewController.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit


fileprivate let goBackSegue: String = "goBack"


/// wraps TextBubbleView so it works with constraints
/// .
/// implementuje obsługę constraintsó∑ dla TextBubbleView
class ASD: TextBubbleView {
    override func layoutSubviews() {
        super.layoutSubviews()
        preferredMaxLayoutWidth = bounds.width
    }
}

/// question view
/// .
/// widok pytania
class FlatQuestionViewController: UIViewController, AnswerSelectorViewDelegate {
    @IBOutlet weak var selectorView: AnswerSelectorView! {
        didSet {
            selectorView.display(answers: question.answers)
            selectorView.goalView = goalView
            selectorView.delegate = self
        }
    }
    
    @IBOutlet weak var goalView: EarthView! {
        didSet {
            selectorView?.goalView = goalView
            goalView?.setForUpdates()
        }
    }
    
    @IBOutlet weak var questionImage: QuestionImageView! {
        didSet {
            questionImage.image = question.questionImage
        }
    }
    
    @IBOutlet weak var padding: NSLayoutConstraint! {
        didSet {
            padding.constant = question.padding
        }
    }
    @IBOutlet weak var bubleView: ASD! {
        didSet {
            bubleView.display(text: question.questionText)
        }
    }
    
    @IBOutlet weak var resultView: AnswerCorrectView! {
        didSet {
            resultView.isHidden = true
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self, action: #selector(goBack)
            )
            resultView.addGestureRecognizer(tap)
        }
    }
    
    /// question to display
    /// .
    /// pytanie do wyświetlenia
    var question: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.App.backgroundColor
    }
    
    
    @objc private func goBack() {
        performSegue(withIdentifier: goBackSegue, sender: nil)
    }
    
    // MARK: AnswerSelectorViewDelegate
    func answerSelectorView(_ view: AnswerSelectorView, didSelect index: Int) {
        resultView.isHidden = false
        resultView.asd()
        if question.correctAnswer == index {
            resultView.success(he: true)
            MainModel.instace.correctAnswer()
        } else {
            MainModel.instace.wrongAnswer()
            resultView.success(he: false)
        }
        
    }
    
    
}


