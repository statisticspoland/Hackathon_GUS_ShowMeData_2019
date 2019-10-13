//
//  MainModel.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import RxSwift




fileprivate let minHappines: Int = -50
fileprivate let maxHappines: Int = 59

/// handles logic of application
/// .
/// obsługuje logikę aplikacji
class MainModel {
    /// current name of the planet
    /// .
    /// aktualne imię planety
    var name: String? = UserDefaults.standard.name ?? "Staś" {
        didSet {
            guard name != oldValue else { return }
            guard name != nil else { return }
            UserDefaults.standard.name = name
            _nameStream.onNext(name!)
        }
    }
    
    private let _nameStream: BehaviorSubject<String> = BehaviorSubject<String>(
        value: UserDefaults.standard.name ?? ""
    )
    
    /// stream of name changes
    /// .
    /// strumień zmian imienia
    var nameStream: Observable<String> {
        return _nameStream
    }
    
    private(set) var allCoins: Int = UserDefaults.standard.all_coins {
        didSet {
            guard allCoins != oldValue else { return }
            UserDefaults.standard.all_coins = allCoins
            _allCoinsStream.onNext(allCoins)
        }
    }
    
    private let _allCoinsStream: BehaviorSubject<Int> = BehaviorSubject<Int>(
        value: UserDefaults.standard.all_coins
    )
    
    /// stream of all obtained coins
    /// .
    /// strumień wszystkich uzyskanych punktów
    var allCoinsStream: Observable<Int> {
        return _allCoinsStream
    }
    
    var timer: Timer! = nil
    
    private(set) var coins: Int = UserDefaults.standard.my_coins {
        didSet {
            guard coins != oldValue else { return }
            _coinsStream.onNext(coins)
            UserDefaults.standard.my_coins = coins
        }
    }
    private let _coinsStream: BehaviorSubject<Int> = BehaviorSubject<Int>(
        value: UserDefaults.standard.my_coins
    )
    
    /// stream of current coins
    /// .
    /// strumień aktualnie posiadanych punktów
    var coinsStream: Observable<Int> {
        return _coinsStream
    }
    
    private var happiness: Int = UserDefaults.standard.my_happiness {
        didSet {
            guard happiness != oldValue else { return }
            _happinessStream.onNext(happiness)
            UserDefaults.standard.my_happiness = happiness
        }
    }
    
    private let _happinessStream: BehaviorSubject<Int> = BehaviorSubject<Int>(
        value: UserDefaults.standard.my_happiness
    )
    
    private var question_index: Int = UserDefaults.standard.last_question {
        didSet {
            guard question_index != oldValue else { return }
            UserDefaults.standard.last_question = question_index
        }
    }
    
    private let _taskIdxStream: BehaviorSubject<Int> = BehaviorSubject<Int>(
        value: UserDefaults.standard.last_question
    )
    
    private let _answerStream: PublishSubject<Task> = PublishSubject<Task>()
    
    /// stream of tasks
    /// .
    /// strumień kolejnych zadań
    let taskStream: Observable<Task>
    
    
    private init() {
        
        let tasks: Observable<Task> = _taskIdxStream.map {
            (idx: Int) -> Task in
            return possibleTasks[idx % possibleTasks.count]
        }
        taskStream = Observable.merge(tasks, _answerStream)
        
        timer = Timer.scheduledTimer(
            withTimeInterval: TimeInterval(3),
            repeats: true,
            block: {
                [weak self] _ in
                self?.timerTick()
            }
        )
    }
    
    deinit {
        timer?.invalidate()
    }
    
    static var instace: MainModel = MainModel()
    
    /// stream of planet happiness
    /// .
    /// strumięń zadowlenia planety
    var happinesStream: Observable<Earth> {
        return _happinessStream.map { Earth.from(happiness: $0 / 10) }
    }
    
    var rank: Int {
        return allCoins / 200
    }
    
    /// stream of current rank
    /// .
    /// strumień aktualnej rangi
    var rankStream: Observable<Int> {
        return allCoinsStream.map { $0 / 200 }
    }
    
    
    private func timerTick() {
//        happiness = max(happiness - 2, minHappines)
    }
    
    
    private func scheduleNextQuestion() {
        _taskIdxStream.onNext(question_index)
    }
    
    /// add coinst
    /// .
    /// dodaj punkty
    func add(coins: Int) {
        guard coins >= 0 else { fatalError() }
        self.coins += coins
        self.allCoins += coins
    }
    
    
    /// buy something for amounts of coins
    /// .
    /// kup coś w zamian za punkty
    func buy(coins: Int) -> Bool {
        guard self.coins >= coins else {
            return false
        }
        self.coins -= coins
        return true
    }
    
    /// reward correct answer
    /// .
    /// przydzile nagrodę za poprawna odpowiedź
    func correctAnswer() {
        happiness = min(happiness + 12, maxHappines)
        add(coins: 200)
        _answerStream.onNext(Task.correctAnswer)
        
        countForNextQuestion()
    }
    
    
    /// punish wrong answer
    /// .
    /// ukaraj błedną odpowiedź
    func wrongAnswer() {
        happiness = max(happiness - 25, minHappines)
        _answerStream.onNext(Task.wrongAnswer)
        countForNextQuestion()
    }
    
    
    private var nextQuestionTimer: Timer?
    private func countForNextQuestion() {
        question_index += 1
        nextQuestionTimer = Timer.scheduledTimer(
            withTimeInterval: TimeInterval(0.5),
            repeats: false,
            block: {
                [weak self] (_) in
                self?.scheduleNextQuestion()
            }
        )
    }
    
    /// stream of currently used item
    var boughtShopcategory: Variable<ShopCategory> = Variable(.none)
    /// stream of all bought items
    var ownShopCategories: Variable<Set<ShopCategory>> = Variable([.none])
}
