//
//  ShopCellView.swift
//  Gus2
//
//  Created by Mateusz Orzoł on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import RxSwift


/// Cell of one of the objects from shop
/// Komórka pojedynczego obiektu ze sklepu
class ShopCellView: BasicView {
    
    /// Shop object category
    /// Kategoria obiektu ze sklepu
    var category: ShopCategory = .none
    let disposeVBAg = DisposeBag()
    
    private let dymek: UIImageView = {
        let dymek = UIImageView()
        dymek.image = #imageLiteral(resourceName: "232E8FF8-6D9D-46C9-9E8E-A46EF548ED6F")
        dymek.contentMode = .scaleAspectFit
        dymek.backgroundColor = UIColor.clear
        dymek.layer.shadowOpacity = 0.4
        dymek.layer.shadowRadius = 10
        dymek.layer.shadowOffset = CGSize.init(width: 3, height: 6)
        dymek.translatesAutoresizingMaskIntoConstraints = false
        return dymek
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    
    /// Button for buying
    /// Przycisk kupna
    private let price: MainCreditsButton = {
        let a = MainCreditsButton()
        a.addTarget(self, action: #selector(buy), for: .touchUpInside)
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()
    
    
    /// Button of selecting object
    /// Przycisk wyboru obiektu
    private lazy var bought: UIImageView = {
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
        dymek.layer.cornerRadius = 30
        dymek.translatesAutoresizingMaskIntoConstraints = false
        return dymek
    }()
    
    
    /// Function for buying
    /// Funkcja zakupu
    @objc private func buy() {
        guard MainModel.instace.buy(coins: category.prive) else { return }
        MainModel.instace.ownShopCategories.value.insert(category)
    }
    
    /// Setting object as selected in main model (will be shown in main screen)
    /// Ustawinie obiektu jako wybranego w głównym modelu (bedzie pokazywany na ekranie głównym)
    @objc private func settinio() {
        MainModel.instace.boughtShopcategory.value = category
    }
    
    /// Binding views data with logic form main model
    /// Połączenie danych z widoków z logiką z głównego modelu
    private func bind() {
        MainModel.instace.ownShopCategories.asObservable().subscribe(onNext: { (set) in
            if set.contains(self.category) {
                self.set(bought: true)
            } else {
                self.set(bought: false)
            }
        }).disposed(by: disposeVBAg)
    }

    override func initialize() {
        super.initialize()
        backgroundColor = UIColor.App.backgroundColorDarker
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize.init(width: 3, height: 6)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(dymek)
        addSubview(label)
        addSubview(price)
        addSubview(bought)
        NSLayoutConstraint.activate([
            dymek.widthAnchor.constraint(equalToConstant: 80),
            dymek.heightAnchor.constraint(equalToConstant: 80),
            dymek.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dymek.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dymek.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            
            label.leadingAnchor.constraint(equalTo: dymek.trailingAnchor, constant: 15),
            label.centerYAnchor.constraint(equalTo: dymek.centerYAnchor),
            
            price.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            price.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            
            bought.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            bought.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            bought.heightAnchor.constraint(equalToConstant: 60),
            bought.widthAnchor.constraint(equalToConstant: 60)
            ])
        let tap = UITapGestureRecognizer(target: self, action: #selector(settinio))
        bought.addGestureRecognizer(tap)
        bought.isUserInteractionEnabled = true
    }
    
    
    /// Setting data in view
    /// Ustawienie wyswietlany danych na widoku
    func set(category: ShopCategory) {
        self.category = category
        label.text = category.title
        if category != .none {
            self.price.points = category.prive
        }
        self.dymek .image = category.image
        bind()
    }
    
    /// Setting if object is already bought and can be selected
    /// Ustaiwenie czy dany obiekt jest juz kupiony i mozna go wybrac
    func set(bought: Bool) {
        price.isHidden = bought
        self.bought.isHidden = !bought
    }
    
}
