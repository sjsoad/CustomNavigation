//
//  InteractionControllingDelegate.swift
//  AERecord
//
//  Created by Sergey on 17.08.2018.
//

import Foundation

public protocol InteractionControllingDelegate: class {
    
    var sessionAnimator: UIViewPropertyAnimator? { get }
    var context: UIViewControllerContextTransitioning? { get }
    
    func interactionDidUpdate(with progress: CGFloat)
    func interactionDidCanceled()
    func interactionDidEnded()
    
}

public extension InteractionControllingDelegate {
    
    public func interactionDidUpdate(with progress: CGFloat) {
        sessionAnimator?.fractionComplete = progress
        context?.updateInteractiveTransition(progress)
    }
    
    public func interactionDidCanceled() {
        sessionAnimator?.isReversed = true
        sessionAnimator?.continueAnimation()
    }
    
    public func interactionDidEnded() {
        sessionAnimator?.continueAnimation()
    }
    
}
