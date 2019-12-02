//
//  Extensions.swift
//  Temp
//
//  Created by Egor Syrtcov on 21/11/2019.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit

extension UIColor {

        convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
            self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
        static func mainPink() -> UIColor {
            return UIColor(red: 221, green: 94, blue: 86)
    }
}


