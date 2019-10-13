//
//  EarthCategory+MLText.swift
//  Gus2
//
//  Created by Tomasz Lizer on 13/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation


struct ClassificationTask {
    let category: EarthCategory
    let possibleElements: [Classifier]
    let bubbleText: String
    
    
    static var rubbish: ClassificationTask {
        return ClassificationTask.init(
            category: .rubbish,
            possibleElements: [.papier, .smietnik, .butelka],
            bubbleText: "Znajdź mi segregowalne śmieci."
        )
    }
    
    static var cat: ClassificationTask {
        return ClassificationTask.init(
            category: .animals,
            possibleElements: [.kot],
            bubbleText: "Znajdź mi zwierzątko"
        )
    }
    
}
