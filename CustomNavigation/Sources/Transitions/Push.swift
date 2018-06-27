//
//  Push.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

class Push: NSObject, TransitionProvider {
    
    private(set) var transitionDirection: TransitionDirection
    
    init(transitionDirection: TransitionDirection = .fromRight) {
        self.transitionDirection = transitionDirection
    }
    
    func prepareForAnimation(fromView: UIView?, toView: UIView?) {
        guard reverseTransition else {
            toView?.transform = CGAffineTransform(translationX: xPosition(for: toView), y: yPosition(for: toView))
            return }
        toView?.transform = CGAffineTransform(translationX: xPosition(for: toView) * xDelta, y: yPosition(for: toView) * yDelta)
    }
    
    func performAnimation(fromView: UIView?, toView: UIView?) {
        toView?.transform = .identity
        guard reverseTransition else {
            fromView?.transform = CGAffineTransform(translationX: xPosition(for: fromView) * xDelta, y: yPosition(for: fromView) * yDelta)
            return }
        fromView?.transform = CGAffineTransform(translationX: xPosition(for: fromView), y: yPosition(for: fromView))
        
    }
    
    func completeTransition(fromView: UIView?, toView: UIView?) {
        fromView?.transform = .identity
        toView?.transform = .identity
    }
    
    // MARK: - Private -
    
    private func xPosition(for view: UIView?) -> CGFloat {
        guard let view = view else { return 0 }
        switch transitionDirection {
        case .fromRight:
            let multiplier: CGFloat = reverseTransition ? -1 : 1
            return view.frame.size.width * multiplier
        case .fromLeft:
            let multiplier: CGFloat = reverseTransition ? 1 : -1
            return view.frame.size.width * multiplier
        default:
            return 0
        }
    }
    
    private func yPosition(for view: UIView?) -> CGFloat {
        guard let view = view else { return 0 }
        switch transitionDirection {
        case .fromTop:
            return -view.frame.size.height
        case .fromBottom:
            return view.frame.size.height
        default:
            return 0
        }
    }
    
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
