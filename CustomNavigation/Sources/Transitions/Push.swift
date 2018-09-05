//
//  Push.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class Push: DirectionalTransition {
    
    override public func prepareForAnimation(with fromView: UIView?, and toView: UIView?) {
        let xPoint = xPosition(for: toView)
        let yPoint = yPosition(for: toView)
        guard reverseTransition else {
            toView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
            return }
        toView?.transform = CGAffineTransform(translationX: -xPoint * xDelta, y: -yPoint * yDelta)
    }
    
    override public func performAnimation(with fromView: UIView?, and toView: UIView?) {
        let xPoint = xPosition(for: fromView)
        let yPoint = yPosition(for: fromView)
        toView?.transform = .identity
        guard reverseTransition else {
            fromView?.transform = CGAffineTransform(translationX: -xPoint * xDelta, y: -yPoint * yDelta)
            return }
        fromView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
    }
    
    // MARK: - Private -
    
    private var xDelta: CGFloat {
        switch transitionDirection {
        case .fromRight, .fromLeft:
            return pushXDelta
        default:
            return 1
        }
    }
    
    private var yDelta: CGFloat {
        switch transitionDirection {
        case .fromTop, .fromBottom:
            return pushYDelta
        default:
            return 1
        }
    }
}
