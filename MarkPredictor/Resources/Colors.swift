//
//  Colors.swift
//  MarkPredictor
//
//  Created by Елена Яновская on 30.04.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff
        
        self.init(
            red: CGFloat(red) / 0xff,
            green: CGFloat(green) / 0xff,
            blue: CGFloat(blue) / 0xff, alpha: 1
        )
    }
}

struct PaletteColors {
    
    static var blue = UIColor(hex: "285E82")
    static let green = UIColor(hex: "44836B")
    static let teal = UIColor(hex: "388099")
}
