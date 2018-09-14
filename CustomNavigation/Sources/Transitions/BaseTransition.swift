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
    private var subviewsMatchingAnimator: SubviewsMatchingAnimatable?
    
    public init(animatorProvider: AnimatorProvider = DefaultAnimatorProvider()) {
        self.animatorProvider = animatorProvider
    }
    
    // MARK: - CustomAnimatedTransitioning -
    
    public func prepareForAnimation(with fromView: UIView?, and toView: UIView?) {}
    
    public func performAnimation(with fromView: UIView?, and toView: UIView?) {}
    
    public func completeTransition(with fromView: UIView?, and toView: UIView?) {
        fromView?.transform = .identity
        toView?.transform = .identity
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning -
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animatorProvider.duration
    }
    
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        guard let animator = sessionAnimator else {
            return configure(with: transitionContext)
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
    }
    
    // MARK: - Private -
    
    private func configure(with transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        sessionContext = transitionContext
        subviewsMatchingAnimator = SubviewsMathingAnimationProvider(transitionContext: transitionContext)
        let animator = createAnimator()
        let toView = transitionContext.toView()
        let fromView = transitionContext.view(forKey: .from)
        transitionContext.addDestinationView(for: reverseTransition)
        subviewsMatchingAnimator?.prepareForAnimation()
        prepareForAnimation(with: fromView, and: toView)
        addAnimations(with: fromView, and: toView)
        addCompletion(with: fromView, and: toView)
        return animator
    }
    
    private func createAnimator() -> UIViewPropertyAnimator {
        let animator = animatorProvider.animator()
        sessionAnimator = animator
        return animator
    }
    
    private func addAnimations(with fromView: UIView?, and toView: UIView?) {
        sessionAnimator?.addAnimations { [weak self] in
            guard let `self` = self else { return }
            self.subviewsMatchingAnimator?.performAnimation()
            self.performAnimation(with: fromView, and: toView)
        }
    }
    
    private func addCompletion(with fromView: UIView?, and toView: UIView?) {
        sessionAnimator?.addCompletion {  [weak self] (position) in
            guard let `self` = self else { return }
            self.subviewsMatchingAnimator?.completeAnimation()
            self.sessionContext?.completeInteraction(position == .end)
            self.sessionContext?.completeTransition(position == .end)
            self.completeTransition(with: fromView, and: toView)
        }
    }
    
}
