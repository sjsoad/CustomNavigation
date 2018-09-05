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
    
    public func prepareForAnimation(fromView: UIView?, toView: UIView?) {
        print("prepareForAnimation")
    }
    
    public func performAnimation(fromView: UIView?, toView: UIView?) {
        print("performAnimation")
    }
    
    public func completeTransition(fromView: UIView?, toView: UIView?) {
        print("completeTransition")
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning -
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animatorProvider.duration
    }
    
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        sessionContext = transitionContext
        guard let animator = sessionAnimator else {
            let animator = animatorProvider.animator()
            if let toView = transitionContext.toView() {
                let fromView = transitionContext.view(forKey: .from)
                transitionContext.addDestinationView(for: reverseTransition)
                prepareForAnimation(fromView: fromView, toView: toView)
                animator.addAnimations { [weak self] in
                    self?.performAnimation(fromView: fromView, toView: toView)
                }
                animator.addCompletion {  [weak self] (position) in
                    transitionContext.completeInteraction(position == .end)
                    transitionContext.completeTransition(position == .end)
                    self?.completeTransition(fromView: fromView, toView: toView)
                }
                sessionAnimator = animator
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
    
}
