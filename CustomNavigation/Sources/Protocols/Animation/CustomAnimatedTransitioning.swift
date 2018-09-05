//
//  CustomAnimatedTransitioning.swift
//  SKUtils
//
//  Created by Sergey Kostyan on 07.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

public protocol CustomAnimatedTransitioning: UIViewControllerAnimatedTransitioning, InteractionControllerDelegate {
    
    var reverseTransition: Bool { get set }
    
    func animationFinished()
    
    func prepareForAnimation(fromView: UIView?, toView: UIView?)
    func performAnimation(fromView: UIView?, toView: UIView?)
    func completeTransition(fromView: UIView?, toView: UIView?)
}

public extension CustomAnimatedTransitioning {
    
    func animationFinished() {
        reverseTransition = !reverseTransition
    }
    
}
