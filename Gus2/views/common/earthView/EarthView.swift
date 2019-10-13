//
//  EarthView.swift
//  Gus2
//
//  Created by Tomasz Lizer on 12/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import RxSwift

private let earthSize: CGFloat = 300

/// View that displays Earth.
///
/// when using in interface builder, then default Earth style (coolGlass) is applied.
/// When you initiate this class in code, you can set other Starting Earth style.
class EarthView: BasicView {
    
    private var disposeBag: DisposeBag = DisposeBag()
    
    private let imageView: UIImageView = {
        let img: UIImageView = UIImageView()
        img.backgroundColor = UIColor.clear
        img.contentMode = .scaleAspectFill
        img.isUserInteractionEnabled = true
        return img
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup(earth: Earth.coolGlass)
    }
    
    init(_ earth: Earth = .coolGlass) {
        super.init(frame: .zero)
        setup(earth: earth)
    }
    
    
    
    override func initialize() {
        super.initialize()
        
        self.addSubview(imageView)
        backgroundColor = UIColor.clear
        imageView.backgroundColor = UIColor.clear
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.4
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOffset = CGSize.init(width: 3, height: 6)
    }
    
    
    /// Function that setup view, to respect game state.
    /// It means that when Earth state changes, then this view will display new state immediatelly.
    func setForUpdates() {
        disposeBag = DisposeBag()
        MainModel.instace.happinesStream
            .observeOn(MainScheduler.instance).subscribe(
                onNext: {
                    [weak self] (earth: Earth) in
                    print(earth)
                    self?.setup(earth: earth)
                }
            ).disposed(by: disposeBag)
    }
    
    
    func setup(earth: Earth) {
        imageView.image = earth.image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = self.bounds
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize.init(width: earthSize, height: earthSize)
    }
    
}
