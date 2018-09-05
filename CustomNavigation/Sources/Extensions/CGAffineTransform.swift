//
//  CGAffineTransform.swift
//  SKCustomNavigation
//
//  Created by Sergey on 05.09.2018.
//

import UIKit

extension CGAffineTransform {
    
    static var minScale: CGAffineTransform {
        return CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
    
}
