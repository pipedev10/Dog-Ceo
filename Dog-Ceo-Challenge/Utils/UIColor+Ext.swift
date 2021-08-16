//
//  UIColor+Ext.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 15-08-21.
//

import UIKit

extension UIColor {

    static let primaryColor: UIColor? = {
        if #available(iOS 11.0, *) {
            return UIColor(named: "AccentColor")
        }else{
           return UIColor(red: 179 / 255, green: 254 / 255, blue: 255 / 255, alpha: 1)
        }
    }()
    
    
}
