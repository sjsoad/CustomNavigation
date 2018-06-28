//
//  Slide.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class Slide: BaseTransition, DirectionalTransitioning {
    
    public private(set) var transitionDirection: TransitionDirection = .fromTop
    
    public init(transitionDirection: TransitionDirection = .fromTop, animatorProvider: AnimatorProvider = DefaultAnimatorProvider()) {
        super.init(animatorProvider: animatorProvider)
        self.transitionDirection = transitionDirection
    }
    
    override public func prepareForAnimation(fromView: UIView?, toView: UIView?) {
        let xPoint = xPosition(for: toView)
        let yPoint = yPosition(for: toView)
        guard reverseTransition else {
            toView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
            return }
        toView?.transform = CGAffineTransform(translationX: -xPoint, y: -yPoint)
    }
    
    override public func performAnimation(fromView: UIView?, toView: UIView?) {
        let xPoint = xPosition(for: fromView)
        let yPoint = yPosition(for: fromView)
        toView?.transform = .identity
        guard reverseTransition else {
            fromView?.transform = CGAffineTransform(translationX: -xPoint, y: -yPoint)
            return }
        fromView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
    }
    
    override public func completeTransition(fromView: UIView?, toView: UIView?) {
        fromView?.transform = .identity
        toView?.transform = .identity
    }

}
