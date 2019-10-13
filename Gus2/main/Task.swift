//
//  Task.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit



/// list of all posssible tasks, currenlty they are used in gvien order
/// .
/// lista wszystkuch dostepnych zadań, aktualnie są używane w podanej kolejności
let possibleTasks: [Task] = [
    .question(Question.question1),
    .classification(ClassificationTask.rubbish),
    .classification(ClassificationTask.cat),
    .question(Question.question3),
    .question(Question.question2),
]






/// describes task
/// .
/// opisuje zadanie
enum Task {
    /// question
    /// .
    /// pytanie
    case question(Question)
    /// classification task
    /// .
    /// zafanie na rozpoznanie obrazu
    case classification(ClassificationTask)
    /// wait between tasks
    /// .
    /// oczekiwanie między pytaniami
    case waitnig(movie: String)
    
    
    
    /// name of movie that should be displied on main screen
    /// .
    /// nazwa filmu do wyświetlenia na głównym ekranie
    var movie: String {
        switch self {
        case .question(let q):
            return q.movie
        case .classification(let task):
            return task.movie
        case .waitnig(let movie):
            return movie
        }
    }
    
    /// says if it can be started (start button is visible)
    /// .
    /// odpowiada czy może być zaczęte (guzik startu będzie widoczny)
    var isTask: Bool {
        switch self {
        case .question, .classification:
            return true
        default:
            return false
        }
    }
    
    
    /// wait after correct answer
    /// .
    /// oczekiwanie po poprawnej odpowiedzi
    static var correctAnswer: Task {
        return Task.waitnig(movie: "Las")
    }
    
    
    /// wait after wrong answer
    /// .
    /// oczekiwanie po błędnej odpowiedzi
    static var wrongAnswer: Task {
        return Task.waitnig(movie: "sad")
    }
}



/// defines question
/// .
/// opisuje pytanie
struct Question {
    /// movie on main screen
    /// .
    /// film na głównym ekranie
    let movie: String
    /// text of the question
    /// .
    /// treść pytania
    let questionText: String
    /// chart image of the question
    /// .
    /// obrazek wykresu do pytania
    let questionImage: UIImage
    /// list of possible answers
    /// .
    /// lista dostępnych pytań
    let answers: [(String, UIColor)]
    /// index of correct answer
    /// .
    /// indeks poprawnej odpowiedzi
    let correctAnswer: Int
    
    
    /// additional padding for image
    /// .
    /// dodatkowy margines na cel obrazka
    let padding: CGFloat
    
    static let question1: Question = Question(
        movie: "air",
        questionText: "Mam problem z powietrzem. Z kogo brać przykład?",
        questionImage: UIImage.App.question_1,
        answers: [
            ("Niemcy", UIColor.App.chartBlue),
            ("Francja", UIColor.App.chartGreen),
            ("Polska", UIColor.App.chartYellow),
        ],
        correctAnswer: 1,
        padding: 24.0
    )
    
    static let question2: Question = Question(
        movie: "fauna",
        questionText: "Na ziemi żyje mało żubrów. Które województwo mam naśladować aby jak najlepiej o nie dbać?",
        questionImage: UIImage.App.question_2,
        answers: [
            ("Podlaskie", UIColor.App.chartGreen),
            ("Podkarpackie", UIColor.App.chartBlue)
        ],
        correctAnswer: 0,
        padding: 4.0
    )
    
    static let question3: Question = Question(
        movie: "water",
        questionText: "Chcę zredukować zużycie wody. Zmiany z którego roku powinienem sprawdzić?",
        questionImage: UIImage.App.question_3,
        answers: [
            ("2012", UIColor.App.chartBlue),
            ("2008", UIColor.App.chartBlue),
            ("2007", UIColor.App.chartBlue),
        ],
        correctAnswer: 2,
        padding: CGFloat(24.0)
    )
}
