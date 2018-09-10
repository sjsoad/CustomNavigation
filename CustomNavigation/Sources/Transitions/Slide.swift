//
//  Slide.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class Slide: DirectionalTransition {
    
    override public func prepareForAnimation(with fromView: UIView?, and toView: UIView?) {
        let multiplier: CGFloat = reverseTransition ? -1 : 1
        let xPoint = xPosition(for: toView) * multiplier
        let yPoint = yPosition(for: toView) * multiplier
        toView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
    }
    
    override public func performAnimation(with fromView: UIView?, and toView: UIView?) {
        let multiplier: CGFloat = reverseTransition ? 1 : -1
        let xPoint = xPosition(for: fromView) * multiplier
        let yPoint = yPosition(for: fromView) * multiplier
        toView?.transform = .identity
        fromView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
    }

}
