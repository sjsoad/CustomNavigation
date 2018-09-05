//
//  ZoomSlide.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class ZoomSlide: ScaleTransition {
    
    override public func prepareForAnimation(fromView: UIView?, toView: UIView?) {
        let xPoint = xPosition(for: toView)
        let yPoint = yPosition(for: toView)
        let multiplier: CGFloat = reverseTransition ? -1 : 1
        var transform = CGAffineTransform(translationX: multiplier * xPoint, y: multiplier * yPoint)
        transform = transform.scaledBy(x: scale, y: scale)
        toView?.transform = transform
    }
    
    override public func performAnimation(fromView: UIView?, toView: UIView?) {
        let xPoint = xPosition(for: fromView)
        let yPoint = yPosition(for: fromView)
        toView?.transform = .identity
        let multiplier: CGFloat = reverseTransition ? 1 : -1
        var transform = CGAffineTransform(translationX: multiplier * xPoint, y: multiplier * yPoint)
        transform = transform.scaledBy(x: scale, y: scale)
        fromView?.transform = transform
    }

}
