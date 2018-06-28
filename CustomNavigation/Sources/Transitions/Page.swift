//
//  Page.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class Page: BaseTransition, DirectionalTransitioning {

    public private(set) var transitionDirection: TransitionDirection = .fromRight
    public private(set) var scale: CGFloat = 0.8
    
    public init(transitionDirection: TransitionDirection = .fromRight, scale: CGFloat = 0.8,
                animatorProvider: AnimatorProvider = DefaultAnimatorProvider()) {
        super.init(animatorProvider: animatorProvider)
        self.transitionDirection = transitionDirection
        self.scale = scale
    }
    
    override public func prepareForAnimation(fromView: UIView?, toView: UIView?) {
        let xPoint = xPosition(for: toView)
        let yPoint = yPosition(for: toView)
        guard reverseTransition else {
            toView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
            return }
        toView?.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    override public func performAnimation(fromView: UIView?, toView: UIView?) {
        let xPoint = xPosition(for: fromView)
        let yPoint = yPosition(for: fromView)
        toView?.transform = .identity
        guard reverseTransition else {
            fromView?.transform = CGAffineTransform(scaleX: scale, y: scale)
            return }
        fromView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
    }
    
    override public func completeTransition(fromView: UIView?, toView: UIView?) {
        fromView?.transform = .identity
        toView?.transform = .identity
    }
    
}
