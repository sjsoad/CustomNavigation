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
    
    private func fixOrigin(for view: UIView?) {
        guard let view = view else { return }
        var newFrame = view.frame
        newFrame.origin = .zero
        view.frame = newFrame
    }
    
    private func fixSize(topView: UIView?, bottomView: UIView?) {
        guard let topView = topView, let bottomView = bottomView else { return }
        var newFrame = topView.frame
        newFrame.size = bottomView.frame.size
        topView.frame = newFrame
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
        let subviewsAnimationProvider = SubviewsAnimationProvider(transitionContext: transitionContext)
        if reverseTransition {
            addSubviews(topView: fromView, bottomView: toView, to: container)
            // fix for modal presented controllers
            fixSize(topView: fromView, bottomView: toView)
        } else {
            addSubviews(topView: toView, bottomView: fromView, to: container)
            // fix for modal presented controllers
            fixSize(topView: toView, bottomView: fromView)
        }
        subviewsAnimationProvider.prepareForAnimation()
        // fix, because user can interact with view very fast and not complete the transition, in this case origin of view will
        // be changed and may cause corruption of animation
        fixOrigin(for: toView)
        prepareForAnimation(fromView: fromView, toView: toView)
        let animator = animatorProvider.animator()
        animator.addAnimations { [weak self] in
            subviewsAnimationProvider.performAnimation()
            self?.performAnimation(fromView: fromView, toView: toView)
        }
        animator.addCompletion {  [weak self] (position) in
            switch position {
            case .end:
                self?.animationFinished()
                subviewsAnimationProvider.completeAnimation()
                self?.completeTransition(fromView: fromView, toView: toView)
            default:
                subviewsAnimationProvider.prepareForAnimation()
                self?.prepareForAnimation(fromView: fromView, toView: toView)
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
