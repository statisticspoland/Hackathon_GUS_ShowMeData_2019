//
//  rankView.swift
//  Gus2
//
//  Created by Mateusz Orzoł on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


/// View of rank in main screen in top left corner
/// Widok rangi wyswietlany na ekranie glownym w lewym gornym rogu
class rankView: BasicView {
    
    var rank: Int = 0 {
        didSet {
            label.text = "\(rank)"
        }
    }
    
    private let dymek: UIImageView = {
        let dymek = UIImageView()
        dymek.image = #imageLiteral(resourceName: "232E8FF8-6D9D-46C9-9E8E-A46EF548ED6F")
        dymek.contentMode = .scaleAspectFill
        dymek.backgroundColor = UIColor.clear
        dymek.translatesAutoresizingMaskIntoConstraints = false
        return dymek
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = UIColor.white
        label.text = "99"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Setting intrisic view size
    /// Ustawienie podstawowych wymiarow widoku
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 40, height: 20)
    }
    
    override func initialize() {
        super.initialize()
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(dymek)
        addSubview(label)
        NSLayoutConstraint.activate([
            dymek.widthAnchor.constraint(equalTo: widthAnchor),
            dymek.heightAnchor.constraint(equalTo: heightAnchor),
            dymek.centerYAnchor.constraint(equalTo: centerYAnchor),
            dymek.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
    }
}
