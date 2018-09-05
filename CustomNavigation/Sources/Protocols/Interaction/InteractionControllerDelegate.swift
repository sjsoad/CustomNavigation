//
//  InteractionControllerDelegate.swift
//
//
//  Created by Sergey on 17.08.2018.
//

import Foundation

public protocol InteractionControllerDelegate: class {
    
    var sessionAnimator: UIViewPropertyAnimator? { get }
    var sessionContext: UIViewControllerContextTransitioning? { get }
    
    func interactionDidUpdate(with progress: CGFloat)
    func interactionDidCanceled()
    func interactionDidEnded()
    
}

public extension InteractionControllerDelegate {
    
    public func interactionDidUpdate(with progress: CGFloat) {
        sessionAnimator?.fractionComplete = progress
        sessionContext?.updateInteractiveTransition(progress)
    }
    
    public func interactionDidCanceled() {
        sessionAnimator?.isReversed = true
        sessionAnimator?.continueAnimation()
    }
    
    public func interactionDidEnded() {
        sessionAnimator?.continueAnimation()
    }
    
}
