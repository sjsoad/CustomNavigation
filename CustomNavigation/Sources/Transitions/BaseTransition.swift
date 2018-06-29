//
//  BaseTransition.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 28.06.2018.
//

import UIKit

open class BaseTransition: NSObject, CustomAnimatedTransitioning, TransitionProvider {
    
    public private(set) var sessionAnimator: UIViewImplicitlyAnimating?
    
    public var animatorProvider: AnimatorProvider
    open var reverseTransition: Bool = false
    
    public init(animatorProvider: AnimatorProvider = DefaultAnimatorProvider()) {
        self.animatorProvider = animatorProvider
    }
    
    // MARK: - Private -
    
    private func addSubviews(topView: UIView?, bottomView: UIView?, to container: UIView) {
        topView?.transform = .identity
        bottomView?.transform = .identity
        if let bottomView = bottomView {
            container.addSubview(bottomView)
            topView?.frame = bottomView.frame
        }
        if let topView = topView {
            container.addSubview(topView)
        }
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning -
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animatorProvider.duration
    }
    
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if let sessionAnimator = sessionAnimator {
            return sessionAnimator
        }
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        if reverseTransition {
            addSubviews(topView: fromView, bottomView: toView, to: container)
        } else {
            addSubviews(topView: toView, bottomView: fromView, to: container)
        }
        prepareForAnimation(fromView: fromView, toView: toView)
        let animator = animatorProvider.animator()
        animator.addAnimations { [weak self] in
            self?.performAnimation(fromView: fromView, toView: toView)
        }
        animator.addCompletion {  [weak self] (position) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            guard position == .end else { return }
            self?.completeTransition(fromView: fromView, toView: toView)
        }
        sessionAnimator = animator
        return animator
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }
    
    public func animationEnded(_ transitionCompleted: Bool) {
        animationFinished()
        sessionAnimator = nil
    }
    
    // MARK: - TransitionProvider -
    
    public func prepareForAnimation(fromView: UIView?, toView: UIView?) {
        
    }
    
    public func performAnimation(fromView: UIView?, toView: UIView?) {
        
    }
    
    public func completeTransition(fromView: UIView?, toView: UIView?) {
        
    }
    
}
