//
//  CustomAnimatedTransitioning.swift
//  SKUtils
//
//  Created by Sergey Kostyan on 07.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

public protocol CustomAnimatedTransitioning: UIViewControllerAnimatedTransitioning, TransitionProvider, InteractionControllingDelegate {
    
    var reverseTransition: Bool { get set }
    
    func animationFinished()
    
}

public extension CustomAnimatedTransitioning {
    
    func animationFinished() {
        reverseTransition = !reverseTransition
    }
    
}
