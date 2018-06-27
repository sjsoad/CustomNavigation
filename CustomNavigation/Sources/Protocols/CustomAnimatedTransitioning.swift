//
//  CustomAnimatedTransitioning.swift
//  SKUtils
//
//  Created by Sergey Kostyan on 07.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

public protocol CustomAnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    
    var reverseTransition: Bool { get set } // reverseTransition false means it's push/present, true - pop/dismiss
    
    func animationFinished()
    
}

public extension CustomAnimatedTransitioning {
    
    func animationFinished() {
        reverseTransition = !reverseTransition
    }
    
}
