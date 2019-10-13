//
//  EarthHomeView.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 12/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import RxSwift
import UIKit


/// Main view of app
/// Główny widok aplikacji
class EarthHomeView: BasicView {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    private let earth: EarthView = {
        let earth = EarthView(Earth.cat)
        earth.translatesAutoresizingMaskIntoConstraints = false
        earth.setForUpdates()
        return earth
    }()
    
    private let horizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let earthShadon: UIImageView = {
      let view = UIImageView()
        view.image = #imageLiteral(resourceName: "shadow_2")
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// View of selected object form shop
    /// Widok wybranego obiektu ze sklepu
    private let castle: UIImageView = {
        let viwe = UIImageView()
        viwe.contentMode = .scaleAspectFit
        viwe.backgroundColor = UIColor.clear
        viwe.translatesAutoresizingMaskIntoConstraints = false
        return viwe
    }()
    
    private let dymekLeft: dymekView = {
        $0.setLeftDicrection()
        return $0
    }(dymekView())
    
    private let dymekRight = dymekView()
    
    override func initialize() {
        super.initialize()
        setupUI()
    }
    
    func animateEarth() {
        self.earth.transform = CGAffineTransform.identity
        self.dymekLeft.transform = CGAffineTransform.identity
        self.dymekRight.transform = CGAffineTransform.identity
        self.dymekLeft.alpha = 1.0
        self.dymekRight.alpha = 1.0
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
                self.earth.transform = CGAffineTransform.init(translationX: 0, y: -40)
                self.dymekLeft.transform = CGAffineTransform.init(translationX: -10, y: 10)
                self.dymekRight.transform = CGAffineTransform.init(translationX: 10, y: 10)
                self.dymekLeft.alpha = 0.0
                self.dymekRight.alpha = 0.0
        }
        )
    }

    
    private func setupUI() {
        backgroundColor = UIColor.App.backgroundColorDarker
        clipsToBounds = false
        addSubview(horizontalLine)
        addSubview(castle)
        addSubview(earthShadon)
        addSubview(earth)
        addSubview(dymekLeft)
        addSubview(dymekRight)
        setupConstraints()
        bind()
    }
    
    /// Binding views data with logic form main model
    /// Połączenie danych z widoków z logiką z głównego modelu
    private func bind() {
        MainModel.instace.boughtShopcategory.asObservable().subscribe(onNext: { (category) in
            self.castle.image = category.image
        }).disposed(by: disposeBag)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
                castle.heightAnchor.constraint(equalTo: castle.widthAnchor, multiplier: 1.3),
                castle.widthAnchor.constraint(equalTo: widthAnchor),
                castle.bottomAnchor.constraint(equalTo: topAnchor, constant: 80),
                castle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
                earth.centerXAnchor.constraint(equalTo: centerXAnchor),
                earthShadon.bottomAnchor.constraint(equalTo: topAnchor, constant: 130),
                earth.widthAnchor.constraint(equalToConstant: 300),
                earth.heightAnchor.constraint(equalToConstant: 300),
                
                earthShadon.topAnchor.constraint(equalTo: earth.bottomAnchor, constant: -60),
                earthShadon.centerXAnchor.constraint(equalTo: earth.centerXAnchor),
                earthShadon.widthAnchor.constraint(equalTo: earth.widthAnchor, multiplier: 0.4),
                earthShadon.heightAnchor.constraint(equalTo: earthShadon.widthAnchor, multiplier: 0.2),
                
                dymekLeft.trailingAnchor.constraint(equalTo: earth.leadingAnchor, constant: 90),
                dymekLeft.centerYAnchor.constraint(equalTo: earthShadon.centerYAnchor, constant: -30),
                
                dymekRight.centerYAnchor.constraint(equalTo: dymekLeft.centerYAnchor),
                dymekRight.leadingAnchor.constraint(equalTo: earth.trailingAnchor, constant: -90),
                
                horizontalLine.heightAnchor.constraint(equalToConstant: 4),
                horizontalLine.leadingAnchor.constraint(equalTo: leadingAnchor),
                horizontalLine.trailingAnchor.constraint(equalTo: trailingAnchor),
                horizontalLine.bottomAnchor.constraint(equalTo: topAnchor)
            ])
    }
    
}
