//
//  BaseTransition.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 28.06.2018.
//

import UIKit

open class BaseTransition: NSObject, CustomAnimatedTransitioning, TransitionProvider {

    public var animatorProvider: AnimatorProvider
    open var reverseTransition: Bool = false
    
    public init(animatorProvider: AnimatorProvider = DefaultAnimatorProvider()) {
        self.animatorProvider = animatorProvider
    }
    
    // MARK: - Private -
    
    private func addSubviews(topView: UIView?, bottomView: UIView?, to container: UIView) {
        if let bottomView = bottomView {
            container.addSubview(bottomView)
        }
        if let topView = topView {
            container.addSubview(topView)
        }
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning -
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animatorProvider.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
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
        animator.addCompletion {  [weak self] (_) in
            self?.animationFinished()
            self?.completeTransition(fromView: fromView, toView: toView)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        animator.startAnimation()
    }
    
    // MARK: - TransitionProvider -
    
    public func prepareForAnimation(fromView: UIView?, toView: UIView?) {
        
    }
    
    public func performAnimation(fromView: UIView?, toView: UIView?) {
        
    }
    
    public func completeTransition(fromView: UIView?, toView: UIView?) {
        
    }
    
}
