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
    public private(set) var context: UIViewControllerContextTransitioning?
    open var reverseTransition: Bool = false
    
    public var animatorProvider: AnimatorProvider
    
    public init(animatorProvider: AnimatorProvider = DefaultAnimatorProvider()) {
        self.animatorProvider = animatorProvider
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning -
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animatorProvider.duration
    }
    
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        context = transitionContext
        guard let animator = sessionAnimator else {
            let animator = animatorProvider.animator()
            if let toView = transitionContext.view(forKey: .to) {
                let fromView = transitionContext.view(forKey: .from)
                if reverseTransition {
                    transitionContext.containerView.insertSubview(toView, at: 0)
                } else {
                    transitionContext.containerView.addSubview(toView)
                }
                let subviewsAnimationProvider = SubviewsAnimationProvider(transitionContext: transitionContext)
                subviewsAnimationProvider.prepareForAnimation()
                prepareForAnimation(fromView: fromView, toView: toView)
                animator.addAnimations { [weak self] in
                    subviewsAnimationProvider.performAnimation()
                    self?.performAnimation(fromView: fromView, toView: toView)
                }
                animator.addCompletion {  [weak self] (position) in
                    if position == .end {
                        transitionContext.finishInteractiveTransition()
                    } else {
                        transitionContext.cancelInteractiveTransition()
                    }
                    transitionContext.completeTransition(position == .end)
                    subviewsAnimationProvider.completeAnimation()
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
        context = nil
        guard transitionCompleted else { return }
        animationFinished()
    }
    
    // MARK: - TransitionProvider -
    
    public func prepareForAnimation(fromView: UIView?, toView: UIView?) {
        print("prepareForAnimation")
    }
    
    public func performAnimation(fromView: UIView?, toView: UIView?) {
        print("performAnimation")
    }
    
    public func completeTransition(fromView: UIView?, toView: UIView?) {
        print("completeTransition")
    }
    
}
