//
//  BaseTransition.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 28.06.2018.
//

import UIKit
import SKAnimator

open class BaseTransition: NSObject, CustomAnimatedTransitioning, TransitionProvider, InteractionControllingDelegate {
    
    public private(set) var interactionController: InteractionControlling?
    public private(set) var sessionAnimator: UIViewImplicitlyAnimating?
    public private(set) var context: UIViewControllerContextTransitioning?
    open var reverseTransition: Bool = false
    
    public var animatorProvider: AnimatorProvider
    
    public init(animatorProvider: AnimatorProvider = DefaultAnimatorProvider(), interactionController: InteractionControlling? = nil) {
        self.animatorProvider = animatorProvider
        self.interactionController = interactionController
        super.init()
        interactionController?.interactionDelegate = self
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
    
    private func continueAnimation() {
        guard let propertyAnimator = sessionAnimator as? UIViewPropertyAnimator else { return }
        let animationDuration = CGFloat(propertyAnimator.duration)
        let durationFactor = animationDuration - animationDuration * propertyAnimator.fractionComplete
        propertyAnimator.continueAnimation(withTimingParameters: propertyAnimator.timingParameters, durationFactor: durationFactor)
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning -
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animatorProvider.duration
    }
    
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        context = transitionContext
        guard let animator = sessionAnimator else {
            let animator = animatorProvider.animator()
            let toView = transitionContext.view(forKey: .to)
            let fromView = transitionContext.view(forKey: .from)
            let toViewController = transitionContext.viewController(forKey: .to)
            if let toViewController = toViewController {
                toView?.frame = transitionContext.finalFrame(for: toViewController)
            }
            if reverseTransition {
                addSubviews(topView: fromView, bottomView: toView, to: transitionContext.containerView)
            } else {
                addSubviews(topView: toView, bottomView: fromView, to: transitionContext.containerView)
            }
            let subviewsAnimationProvider = SubviewsAnimationProvider(transitionContext: transitionContext)
            subviewsAnimationProvider.prepareForAnimation()
            prepareForAnimation(fromView: fromView, toView: toView)
            animator.addAnimations { [weak self] in
                subviewsAnimationProvider.performAnimation()
                self?.performAnimation(fromView: fromView, toView: toView)
            }
            animator.addCompletion {  [weak self] (position) in
                switch position {
                case .end:
                    transitionContext.finishInteractiveTransition()
                    transitionContext.completeTransition(true)
                default:
                    transitionContext.cancelInteractiveTransition()
                    transitionContext.completeTransition(false)
                }
                subviewsAnimationProvider.completeAnimation()
                self?.completeTransition(fromView: fromView, toView: toView)
            }
            sessionAnimator = animator
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
        
    }
    
    public func performAnimation(fromView: UIView?, toView: UIView?) {
        
    }
    
    public func completeTransition(fromView: UIView?, toView: UIView?) {
        
    }
    
    // MARK: - InteractionControllingDelegate -
    
    public func interactionDidBegan() {
        
    }
    
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
    
}
