//
//  Colors.swift
//  Gus2
//
//  Created by Paweł Czerwiński on 12/04/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    enum App {
        static var green: UIColor { return UIColor(named: "green")! }
        static var blue: UIColor { return UIColor(named: "blue")! }
        static var gray: UIColor { return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) }

        static var chartBlue: UIColor {
            return UIColor(named: "chartBlue")!
        }
        static var chartYellow: UIColor {
            return UIColor(named: "chartYellow")!
        }
        static var chartGreen: UIColor {
            return UIColor(named: "chartGreen")!
        }

        static var backgroundColor: UIColor { return #colorLiteral(red: 1, green: 0.8637983203, blue: 0.3910537958, alpha: 1)}
        static var backgroundColorDarker: UIColor { return #colorLiteral(red: 1, green: 0.7846830487, blue: 0.3141322732, alpha: 1)}
        static var buttonColor: UIColor { return #colorLiteral(red: 1, green: 0.4706023932, blue: 0.005172635894, alpha: 1)}

    }
}
