//
//  MainViewController.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 12/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


fileprivate let flatQuestSegue: String = "flat_quest"
fileprivate let mlSegue: String = "classificationMLSegue"
fileprivate let shopSegue: String = "shop"


class MainViewController: UIViewController {
    @IBOutlet weak var backgroundVideo: VideoView! {
        didSet {
            
            if let movie: String = nextTask?.movie {
                backgroundVideo.display(mp4Name: movie)
            }
        }
    }
    @IBOutlet weak var rankView: rankView! {
        didSet {
            rankView?.rank = MainModel.instace.rank
            rankView.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(share)
                )
            )
        }
    }
    
    @IBOutlet weak var startBtn: StartButton! {
        didSet {
            startBtn.setTitle("Oczyść mnie".uppercased(), for: UIControl.State.normal)
            startBtn.addTarget(
                self,
                action: #selector(start),
                for: UIControl.Event.touchUpInside
            )
            startBtn.isHidden = nextTask?.isTask != true
        }
    }
    
    @IBOutlet weak var earthView: EarthHomeView! {
        didSet {
        }
    }
    
    @IBOutlet weak var coinsButton: MainCreditsButton! {
        didSet {
            coinsButton.points = MainModel.instace.allCoins
            MainModel.instace.coinsStream.observeOn(MainScheduler.instance).subscribe(
                onNext: {
                    [weak self] (coins: Int) in
                    self?.coinsButton?.points = coins
                }
            ).disposed(by: disposeBag)
            coinsButton.addTarget(
                self,
                action: #selector(goToShop),
                for: UIControl.Event.touchUpInside
            )
        }
    }
    
    private var nextTask: Task? {
        didSet {
            startBtn?.isHidden = nextTask?.isTask != true
            
            let movie: String = (nextTask ?? Task.correctAnswer).movie
            backgroundVideo?.display(mp4Name: movie)
        }
    }
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        MainModel.instace.taskStream
            .observeOn(MainScheduler.instance).subscribe(
                onNext: {
                    [weak self] (task: Task) in
                    self?.nextTask = task
                }
            ).disposed(by: disposeBag)
        
        MainModel.instace.rankStream
            .observeOn(MainScheduler.instance).subscribe(
                onNext: {
                    [weak self] (rank: Int) in
                    self?.rankView?.rank = rank
                }
            ).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case flatQuestSegue:
            let vc: FlatQuestionViewController = segue.destination
                as! FlatQuestionViewController
            let q: Question = sender as! Question
            vc.question = q
        case mlSegue:
            let vc: CoreMLViewController = segue.destination as! CoreMLViewController
            let task: ClassificationTask = sender as! ClassificationTask
            vc.task = task
        case shopSegue:
            break
        default:
            fatalError()
        }
    }
    
    
    /// start next task
    /// .
    /// rozpocznij następne zadanie
    @objc private func start() {
        guard let nextTask: Task = self.nextTask else { return }
        switch nextTask {
        case .question(let question):
            performSegue(withIdentifier: flatQuestSegue, sender: question)
        case .classification(let classification):
            performSegue(withIdentifier: mlSegue, sender: classification)
        default:
            break
        }
        
    }
    
    
    // MARK: Unwind
    @IBAction func goBack(with: UIStoryboardSegue) {}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        earthView.animateEarth()
    }
    
    
    /// share action
    /// .
    /// obsługa udostęniania
    @objc private func share() {
        let previousState: Bool = startBtn.isHidden
        startBtn.isHidden = true
        let img: UIImage = view.asImage()
        startBtn.isHidden = previousState
        
        let controler = UIActivityViewController(
            activityItems: [img],
            applicationActivities: nil
        )
        
        
        controler.popoverPresentationController?.sourceView = rankView // so that iPads won't crash
        
        
        // present the view controller
        self.present(controler, animated: true)
    }
    
    @objc private func goToShop() {
        performSegue(withIdentifier: shopSegue, sender: nil)
    }
}



extension UIView {
    /// create image from view (movies aren't taken)
    /// .
    /// tworzy obrazek z widoczku (filmy nie są uwzględnione)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}
