//
//  NameMeViewController.swift
//  Gus2
//
//  Created by Tomasz Lizer on 12/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import RxSwift

private let mainSegue: String = "NameToMainSegue"


class NameMeViewController: UIViewController, NameMeViewDelegate {
    
    private let model: OnboardModel = OnboardModel()
    private let nameMeView: NameMeView = NameMeView()
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    override func loadView() {
        self.view = nameMeView
        nameMeView.delegate = self
    }
    
    
    // MARK: - NameMeViewDelegate
    // This function gets called when user succesfully enters name in the first bubble in nameMeView
    func nameMeView(didEntered name: String) {
        MainModel.instace.name = name
        let conv = ConversationItem.init(bubble: "\(name)! Ale fajne imie!", button: "Co dalej?")
        nameMeView.changeBubbles(conv)
    }
    
    // This function gets caled on subsequent clicks during conversation with earth (bottom button clicks).
    func nameMeView(didTappedOk view: NameMeView) {
        if let item = model.nextItem() {
            nameMeView.conversation(item)
            return
        }
        performSegue(withIdentifier: mainSegue, sender: nil)
    }
    
}
