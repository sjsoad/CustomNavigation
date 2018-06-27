//
//  Slide.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class Slide: NSObject, TransitionProvider {
    
    private(set) var transitionDirection: TransitionDirection
    
    public init(transitionDirection: TransitionDirection = .fromTop) {
        self.transitionDirection = transitionDirection
    }
    
    public func prepareForAnimation(fromView: UIView?, toView: UIView?, reverseTransition: Bool) {
        let xPoint = xPosition(for: toView)
        let yPoint = yPosition(for: toView)
        guard reverseTransition else {
            toView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
            return }
        toView?.transform = CGAffineTransform(translationX: -xPoint, y: -yPoint)
    }
    
    public func performAnimation(fromView: UIView?, toView: UIView?, reverseTransition: Bool) {
        let xPoint = xPosition(for: toView)
        let yPoint = yPosition(for: toView)
        toView?.transform = .identity
        guard reverseTransition else {
            fromView?.transform = CGAffineTransform(translationX: -xPoint, y: -yPoint)
            return }
        fromView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
        
    }
    
    public func completeTransition(fromView: UIView?, toView: UIView?) {
        fromView?.transform = .identity
        toView?.transform = .identity
    }
    
    // MARK: - Private -
    
    private func xPosition(for view: UIView?) -> CGFloat {
        guard let view = view else { return 0 }
        switch transitionDirection {
        case .fromRight:
            return view.frame.size.width
        case .fromLeft:
            return -view.frame.size.width
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

}
