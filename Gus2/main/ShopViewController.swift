//
//  ShopViewController.swift
//  Gus2
//
//  Created by Mateusz Orzoł on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import RxSwift

/// Segue of going back to main screen
/// Nazwa przejscia do ekranu głównego
fileprivate let goBackSegue: String = "goBack"

/// View Controller sklepu
/// Kontroller sklepu
class ShopViewController: UIViewController {

    let disp = DisposeBag()

    private let price: MainCreditsButton = {
        let a = MainCreditsButton()
        a.isUserInteractionEnabled = false
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()
    
    private let dymek: UIImageView = {
        let dymek = UIImageView()
        dymek.image = #imageLiteral(resourceName: "orzo2")
        dymek.contentMode = .scaleAspectFit
        dymek.backgroundColor = UIColor.clear
        dymek.isUserInteractionEnabled = true
        dymek.layer.shadowOpacity = 0.4
        dymek.layer.shadowRadius = 10
        dymek.layer.shadowOffset = CGSize.init(width: 3, height: 6)
        dymek.translatesAutoresizingMaskIntoConstraints = false
        return dymek
    }()
    
    
    /// View containing all cells of shop objects
    /// Widok zawierające kolejne komórki z obiektami sklepu
    let stackView: UIStackView = {
        let st = UIStackView()
        st.alignment = .fill
        st.axis = .vertical
        st.distribution = .fillEqually
        st.spacing = 20
       st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    let btn0: ShopCellView = {
        let btn1 = ShopCellView()
        btn1.set(category: ShopCategory.none)
        btn1.translatesAutoresizingMaskIntoConstraints = false
        return btn1
    }()

    let btn1: ShopCellView = {
        let btn1 = ShopCellView()
        btn1.set(category: ShopCategory.castle)
        btn1.translatesAutoresizingMaskIntoConstraints = false
        return btn1
    }()
    
    let btn2: ShopCellView = {
        let btn1 = ShopCellView()
        btn1.set(category: ShopCategory.curtain)
        btn1.translatesAutoresizingMaskIntoConstraints = false
        return btn1
    }()
    
    let btn3: ShopCellView = {
        let btn1 = ShopCellView()
        btn1.set(category: ShopCategory.cat)
        btn1.translatesAutoresizingMaskIntoConstraints = false
        return btn1
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

    /// Ustawienie UI
    func setupUI() {
        view.backgroundColor = UIColor.App.backgroundColor
        view.addSubview(dymek)
        view.addSubview(price)
        view.addSubview(stackView)
        stackView.addArrangedSubview(btn0)
        stackView.addArrangedSubview(btn1)
        stackView.addArrangedSubview(btn2)
        stackView.addArrangedSubview(btn3)
        setupConstraints()
        bind()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToMain))
        dymek.addGestureRecognizer(tap)

    }
    
    /// Binding views data with logic form main model
    /// Połączenie danych z widoków z logiką z głównego modelu
    private func bind() {
        MainModel.instace.coinsStream.subscribe(onNext: { (coins) in
            self.price.points = coins
        }).disposed(by: disp)
        MainModel.instace.boughtShopcategory.asObservable().subscribe(onNext: { (_) in
            self.goToMain()
        }).disposed(by: disp)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dymek.centerYAnchor.constraint(equalTo: price.centerYAnchor),
            dymek.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            dymek.widthAnchor.constraint(equalToConstant: 80),
            dymek.heightAnchor.constraint(equalToConstant: 40),
            
            price.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            price.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            btn1.heightAnchor.constraint(equalToConstant: 100)
            ])
    }
    
    /// Go to main manu function connected to back arrow button
    /// Funkcaj powrotu do głownego ekranu połączona z przyciskiem strzałki
    @objc private func goToMain() {
        performSegue(withIdentifier: goBackSegue, sender: nil)
    }
}
