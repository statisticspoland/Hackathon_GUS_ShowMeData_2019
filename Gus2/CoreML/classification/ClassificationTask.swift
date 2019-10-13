//
//  EarthCategory+MLText.swift
//  Gus2
//
//  Created by Tomasz Lizer on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation


/// Strutcture used by CoreMLViewController
///
/// You should create instance of this struct for each "game task"
/// you want to add for the classificator part of the game.
///
/// Attributes:
///
/// - movie: String corresponding to one of the files in projects video folder
/// (only file name, without .mp4 suffix)
/// - category: Category that task is connected with
/// (eg. if task is to find some animal, then category should be animals)
/// - possibleElements: All Classifier cases that match task
/// - bubbleText: text that appears next to the Earth - kind of task description
/// (should be short)
/// - funnyUrl: URL to the site (or image) with curiosity connected with task
/// if you don't want to attach some curiosity, you can set this attribute to nil.
struct ClassificationTask {
    let movie: String
    let category: EarthCategory
    let possibleElements: [Classifier]
    let bubbleText: String
    let funnyUrl: URL?
    
    
    static var rubbish: ClassificationTask {
        return ClassificationTask.init(
            movie: "air",
            category: .rubbish,
            possibleElements: [.paper, .trash, .bottle],
            bubbleText: "Znajdź mi segregowalne śmieci.",
            funnyUrl: nil
        )
    }
    
    static var cat: ClassificationTask {
        return ClassificationTask.init(
            movie: "sad",
            category: .animals,
            possibleElements: [.cat],
            bubbleText: "Znajdź mi zwierzątko",
            funnyUrl: URL.init(string: "https://scontent-waw1-1.xx.fbcdn.net/v/t1.0-9/38745569_2107370172811067_2532542141989650432_o.jpg?_nc_cat=110&_nc_ht=scontent-waw1-1.xx&oh=b7ddd1b4841496906a23e9dde8c9a89d&oe=5D4FFFDA")
        )
    }
    
}
