//
//  BaseTransition.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 28.06.2018.
//

import UIKit
import SKAnimator

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
        let toViewController = transitionContext.viewController(forKey: .to)
        if let toViewController = toViewController {
            toView?.frame = transitionContext.finalFrame(for: toViewController)
        }
        if reverseTransition {
            addSubviews(topView: fromView, bottomView: toView, to: container)
        } else {
            addSubviews(topView: toView, bottomView: fromView, to: container)
        }
        let subviewsAnimationProvider = SubviewsAnimationProvider(transitionContext: transitionContext)
        subviewsAnimationProvider.prepareForAnimation()
        prepareForAnimation(fromView: fromView, toView: toView)
        let animator = animatorProvider.animator()
        animator.addAnimations { [weak self] in
            subviewsAnimationProvider.performAnimation()
            toViewController?.navigationController
            self?.performAnimation(fromView: fromView, toView: toView)
        }
        animator.addCompletion {  [weak self] (position) in
            switch position {
            case .end:
                subviewsAnimationProvider.completeAnimation()
                self?.completeTransition(fromView: fromView, toView: toView)
                self?.animationFinished()
                transitionContext.finishInteractiveTransition()
            default:
                subviewsAnimationProvider.prepareForAnimation()
                self?.prepareForAnimation(fromView: fromView, toView: toView)
                transitionContext.cancelInteractiveTransition()
            }
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        sessionAnimator = animator
        return animator
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }
    
    public func animationEnded(_ transitionCompleted: Bool) {
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
