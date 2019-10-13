//
//  AnswerCorrectView.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit


fileprivate let paddingX: CGFloat = CGFloat(16.0)


/// View that is shown after answering question
/// .
/// Widok wyświetlany po odpowiedzi na pytanie
class AnswerCorrectView: BasicView {
    
    
    private let topLbl: UILabel = {
        () -> UILabel in
        let topLbl: UILabel = UILabel()
        
        topLbl.textAlignment = NSTextAlignment.center
        topLbl.font = UIFont.boldSystemFont(ofSize: 40)
        topLbl.translatesAutoresizingMaskIntoConstraints = false
        return topLbl
    }()
    
    
    private let middleLbl: UILabel = {
        () -> UILabel in
        let middleLbl: UILabel = UILabel()
        middleLbl.textAlignment = NSTextAlignment.center
        middleLbl.font = UIFont.boldSystemFont(ofSize: 30)
        middleLbl.translatesAutoresizingMaskIntoConstraints = false
        return middleLbl
    }()
    
    private lazy var imgView: UIImageView = {
        let dymek = UIImageView()
        dymek.image = #imageLiteral(resourceName: "star")
        dymek.contentMode = .scaleAspectFit
        dymek.backgroundColor = UIColor.App.buttonColor
        dymek.layer.borderColor = UIColor.black.cgColor
        dymek.layer.borderWidth = 0
        dymek.layer.shadowColor = UIColor.black.cgColor
        dymek.layer.shadowOpacity = 0.4
        dymek.layer.shadowRadius = 10
        dymek.layer.shadowOffset = CGSize.init(width: 3, height: 6)
        dymek.layer.cornerRadius = 80
        dymek.translatesAutoresizingMaskIntoConstraints = false
        return dymek
    }()
    
    private let bottomLbl: UILabel = {
        () -> UILabel in
        let bottomLbl: UILabel = UILabel()
        bottomLbl.text = "Udało Ci się zdobyć:"
        bottomLbl.textAlignment = NSTextAlignment.center
        bottomLbl.font = UIFont.boldSystemFont(ofSize: 30)
        bottomLbl.translatesAutoresizingMaskIntoConstraints = false
        return bottomLbl
    }()
    
    private let coinsBtn: MainCreditsButton = MainCreditsButton()
    
    
    /// start view animation
    /// .
    /// rozpocznij animowanie widoku
    func asd() {
        UIView.animate(
            withDuration: TimeInterval(0.7),
            delay: TimeInterval(0.0),
            usingSpringWithDamping: CGFloat(0.99),
            initialSpringVelocity: CGFloat(0.3),
            options: [
                UIView.AnimationOptions.autoreverse,
                UIView.AnimationOptions.repeat,
                UIView.AnimationOptions.curveEaseOut
            ],
            animations: {
                self.imgView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }
        )
    }

    override func initialize() {
        super.initialize()
        
        backgroundColor = UIColor.App.backgroundColor
        coinsBtn.translatesAutoresizingMaskIntoConstraints = false
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(topLbl)
        addSubview(middleLbl)
        addSubview(imgView)
        
        addSubview(bottomLbl)
        addSubview(coinsBtn)
        coinsBtn.isUserInteractionEnabled = false
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
                topLbl.topAnchor.constraint(equalTo: topAnchor, constant: 150),
                topLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                middleLbl.topAnchor.constraint(equalTo: topLbl.bottomAnchor, constant: 20),
                middleLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                imgView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imgView.centerYAnchor.constraint(equalTo: centerYAnchor),
                imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor),
                imgView.heightAnchor.constraint(equalToConstant: 200),
                
                bottomLbl.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 100),
                bottomLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                coinsBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
                coinsBtn.topAnchor.constraint(equalTo: bottomLbl.bottomAnchor, constant: 10)
            ])
    }
    
    /// display status of answer
    /// .
    /// wyświetl status odpowiedzi
    func success(he: Bool) {
        topLbl.text = he ? "WSPANIALE!" : "NIE PRZEJMUJ SIĘ!"
        middleLbl.text = he ? "\(MainModel.instace.name!) jest zadowolony!" : "\(MainModel.instace.name!) wciąż ma się dobrze"
        imgView.image = he ? #imageLiteral(resourceName: "star") : #imageLiteral(resourceName: "earth_5")
        bottomLbl.text = he ? "Udało Ci się zdobyć:" : "Następnym razem się uda!"
        coinsBtn.isHidden = !he
    }
}
