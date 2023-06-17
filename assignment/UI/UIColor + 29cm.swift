//
//  UIColor + 29cm.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/17.
//

import UIKit

public extension UIColor {
    static let black29cm = UIColor(
        lightColor: .black,
        darkColor: nil
    )
    
    static let white29cm = UIColor(
        lightColor: .white,
        darkColor: nil
    )
    
    static let gray29cm = UIColor(
        lightColor: .init(red: 212 / 255, green: 212 / 255, blue: 212 / 255, alpha: 1),
        darkColor: nil
    )
    
    convenience init(lightColor: UIColor, darkColor: UIColor?) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return darkColor == nil ? lightColor : darkColor!
                
            case .light, .unspecified:
                fallthrough
            @unknown default:
                return lightColor
            }
        }
    }
}

