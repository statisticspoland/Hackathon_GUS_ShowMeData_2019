//
//  dymekView.swift
//  Gus2
//
//  Created by Mateusz Orzoł on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


/// Smoke view that is animating in main screen
/// Widok dymku, który jest animowany na ekraniu głównym
class dymekView: BasicView {
    
    
    private let dymek: UIImageView = {
        let dymek = UIImageView()
        dymek.image = #imageLiteral(resourceName: "shadow")
        dymek.contentMode = .scaleAspectFit
        dymek.backgroundColor = UIColor.clear
        dymek.translatesAutoresizingMaskIntoConstraints = false
        return dymek
    }()
    
    
    /// View rotation by 180 degree
    /// Rotacja widoku o 180 stopni
    func setLeftDicrection() {
        dymek.transform = CGAffineTransform.init(scaleX: -1, y: 1.0)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 40, height: 20)
    }
    
    override func initialize() {
        super.initialize()
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(dymek)
        NSLayoutConstraint.activate([
            dymek.widthAnchor.constraint(equalTo: widthAnchor),
            dymek.heightAnchor.constraint(equalTo: heightAnchor),
            dymek.centerYAnchor.constraint(equalTo: centerYAnchor),
            dymek.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            dymek.widthAnchor.constraint(equalToConstant: 100),
            dymek.heightAnchor.constraint(equalToConstant: 60),
            ])
    }
}
