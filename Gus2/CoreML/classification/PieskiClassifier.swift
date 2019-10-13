//
//  PieskiClassifier.swift
//  Gus2
//
//  Created by Tomasz Lizer on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


/// Object used to map InceptionV3 model to task model and allow its use in app.
enum Classifier: String {
    case trash = "śmietnik"
    case bottle = "butelka"
    case pencil = "długopis"
    case table = "stół"
    case paper = "papier"
    case cat = "kot"
    
    
    init?(mapPrediction txt: String) {
        let low = txt.lowercased()
        if low.contains("cat") {
            self = .cat
            return
        }
        if low.contains("trash") || low.contains("garbage") || low.contains("dustbin") || low.contains("wastebin") {
            self = .trash
            return
        }
        if low.contains("bottle") {
            self = .bottle
            return
        }
        if low.contains("ballpoint") || low.contains("ballpen") || low.contains("Biro") {
            self = .pencil
            return
        }
        if low.contains("table") {
            self = .table
            return
        }
        if low.contains("envelope") {
            self = .paper
            return
        }
        return nil
    }
}
