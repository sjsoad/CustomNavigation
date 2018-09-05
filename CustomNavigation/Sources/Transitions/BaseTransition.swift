//
//  BaseTransition.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 28.06.2018.
//

import UIKit
import SKAnimator

open class BaseTransition: NSObject, CustomAnimatedTransitioning {
    
    public private(set) var sessionAnimator: UIViewPropertyAnimator?
    public private(set) var sessionContext: UIViewControllerContextTransitioning?
    
    open var reverseTransition: Bool = false
    
    public var animatorProvider: AnimatorProvider
    
    public init(animatorProvider: AnimatorProvider = DefaultAnimatorProvider()) {
        self.animatorProvider = animatorProvider
    }
    
    // MARK: - CustomAnimatedTransitioning -
    
    public func prepareForAnimation(with fromView: UIView?, and toView: UIView?) {
        print("prepareForAnimation")
    }
    
    public func performAnimation(with fromView: UIView?, and toView: UIView?) {
        print("performAnimation")
    }
    
    public func completeTransition(with fromView: UIView?, and toView: UIView?) {
        print("completeTransition")
        fromView?.transform = .identity
        toView?.transform = .identity
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning -
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animatorProvider.duration
    }
    
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        sessionContext = transitionContext
        guard let animator = sessionAnimator else {
            let animator = createAnimator()
            if let toView = transitionContext.toView() {
                let fromView = transitionContext.view(forKey: .from)
                transitionContext.addDestinationView(for: reverseTransition)
                prepareForAnimation(with: fromView, and: toView)
                addAnimations(with: fromView, and: toView)
                addCompletion(with: fromView, and: toView)
            }
            return animator
        }
        return animator
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }
    
    public func animationEnded(_ transitionCompleted: Bool) {
        sessionAnimator = nil
        sessionContext = nil
        if transitionCompleted { animationFinished() }
    }
    
    // MARK: - Private -
    
    private func createAnimator() -> UIViewPropertyAnimator {
        let animator = animatorProvider.animator()
        sessionAnimator = animator
        return animator
    }
    
    private func addAnimations(with fromView: UIView?, and toView: UIView?) {
        sessionAnimator?.addAnimations { [weak self] in
            self?.performAnimation(with: fromView, and: toView)
        }
    }
    
    private func addCompletion(with fromView: UIView?, and toView: UIView?) {
        sessionAnimator?.addCompletion {  [weak self] (position) in
            self?.sessionContext?.completeInteraction(position == .end)
            self?.sessionContext?.completeTransition(position == .end)
            self?.completeTransition(with: fromView, and: toView)
        }
    }
    
}
