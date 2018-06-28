//
//  Push.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class Push: BaseTransition, DirectionalTransitioning {
    
    public private(set) var transitionDirection: TransitionDirection = .fromRight
    
    public init(transitionDirection: TransitionDirection = .fromRight, animatorProvider: AnimatorProvider = DefaultAnimatorProvider()) {
        super.init(animatorProvider: animatorProvider)
        self.transitionDirection = transitionDirection
    }
    
    override public func prepareForAnimation(fromView: UIView?, toView: UIView?) {
        let xPoint = xPosition(for: toView)
        let yPoint = yPosition(for: toView)
        guard reverseTransition else {
            toView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
            return }
        toView?.transform = CGAffineTransform(translationX: -xPoint * xDelta, y: -yPoint * yDelta)
    }
    
    override public func performAnimation(fromView: UIView?, toView: UIView?) {
        let xPoint = xPosition(for: fromView)
        let yPoint = yPosition(for: fromView)
        toView?.transform = .identity
        guard reverseTransition else {
            fromView?.transform = CGAffineTransform(translationX: -xPoint * xDelta, y: -yPoint * yDelta)
            return }
        fromView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
    }
    
    override public func completeTransition(fromView: UIView?, toView: UIView?) {
        fromView?.transform = .identity
        toView?.transform = .identity
    }
    
    // MARK: - Private -
    
    private var xDelta: CGFloat {
        switch transitionDirection {
        case .fromRight, .fromLeft:
            return 0.8
        default:
            return 1
        }
    }
    
    private var yDelta: CGFloat {
        switch transitionDirection {
        case .fromTop, .fromBottom:
            return 0.8
        default:
            return 1
        }
    }
}
