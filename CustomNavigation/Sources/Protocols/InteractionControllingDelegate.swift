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
        continueAnimation()
    }
    
    public func interactionDidEnded() {
        continueAnimation()
    }
    
    // MARK: - Private -
    
    private func durationFactor(for propertyAnimator: UIViewPropertyAnimator) -> CGFloat {
        let animationDuration = CGFloat(propertyAnimator.duration)
        return animationDuration - animationDuration * propertyAnimator.fractionComplete
    }
    
    private func continueAnimation() {
        guard let propertyAnimator = sessionAnimator else { return }
        let durationFactor = self.durationFactor(for: propertyAnimator)
        propertyAnimator.continueAnimation(withTimingParameters: propertyAnimator.timingParameters, durationFactor: durationFactor)
    }
    
}
