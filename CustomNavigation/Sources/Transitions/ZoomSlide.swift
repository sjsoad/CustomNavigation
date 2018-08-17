//
//  ZoomSlide.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit
import SKAnimator

open class ZoomSlide: DirectionalTransition {
    
    public private(set) var scale: CGFloat
    
    public init(scale: CGFloat = 0.8, transitionDirection: TransitionDirection = .fromTop,
                animatorProvider: AnimatorProvider = DefaultAnimatorProvider()) {
        self.scale = scale
        super.init(transitionDirection: transitionDirection, animatorProvider: animatorProvider)
    }
    
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
    
    override public func completeTransition(fromView: UIView?, toView: UIView?) {
        fromView?.transform = .identity
        toView?.transform = .identity
    }

}
