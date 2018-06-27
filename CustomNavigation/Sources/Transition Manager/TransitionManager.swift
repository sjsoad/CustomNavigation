//
//  TransitionManager.swift
//  SKUtils
//
//  Created by Sergey on 25.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import Foundation

open class TransitionManager: NSObject, CustomAnimatedTransitioning {
    
    public var animatorProvider: AnimatorProvider
    public var transitionProvider: TransitionProvider
    open var reverseTransition: Bool
    
    public init(transitionProvider: TransitionProvider, reverseTransition: Bool = false,
                animatorProvider: AnimatorProvider = DefaultAnimatorProvider()) {
        self.transitionProvider = transitionProvider
        self.reverseTransition = reverseTransition
        self.animatorProvider = animatorProvider
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning -
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animatorProvider.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        toView.frame = fromView.frame
        reverseTransition == false ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        transitionProvider.prepareForAnimation(fromView: fromView, toView: toView)
        let animator = animatorProvider.animator()
        animator.addAnimations { [weak self] in
            self?.transitionProvider.performAnimation(fromView: fromView, toView: toView)
        }
        animator.addCompletion {  [weak self] (_) in
            self?.animationFinished()
            self?.transitionProvider.completeTransition(fromView: fromView, toView: toView)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        animator.startAnimation()
    }
    
    // MARK: - Private -
    
    // MARK: - Utils -
    
//
//    private func yPoint(for view: UIView, direction: TransitionDirection) -> CGFloat {
//        switch direction {
//        case .fromTop:
//            return -view.frame.size.height
//        case .fromBottom:
//            return view.frame.size.height
//        default:
//            return 0
//        }
//    }
    
    // MARK: - Animation Preparetion -
//
//    private func prepareForSlide(fromView: UIView, toView: UIView, direction: TransitionDirection) {
//        let multiplier: CGFloat = reverseTransition ? -1 : 1
//        toView.transform = CGAffineTransform(translationX: 0, y: multiplier * toView.frame.size.height)
//    }
//
//    private func prepareForZoomPush(fromView: UIView, toView: UIView, direction: TransitionDirection, scale: CGFloat) {
//        let multiplier: CGFloat = reverseTransition ? -1 : 1
//        var transform = CGAffineTransform(translationX: multiplier * toView.frame.size.width, y: 0)
//        transform = transform.scaledBy(x: scale, y: scale)
//        toView.transform = transform
//    }
//
//    private func prepareForCover(fromView: UIView, toView: UIView, direction: TransitionDirection) {
//        guard !reverseTransition else { return }
//        toView.transform = CGAffineTransform(translationX: 0, y: toView.frame.size.height)
//    }
//
//    private func prepareForPage(fromView: UIView, toView: UIView, direction: TransitionDirection, scale: CGFloat) {
//        guard reverseTransition else {
//            toView.transform = CGAffineTransform(translationX: toView.frame.size.width, y: 0)
//            return }
//        toView.transform = CGAffineTransform(scaleX: scale, y: scale)
//    }
//
//    private func prepareForFade(fromView: UIView, toView: UIView) {
//        guard !reverseTransition else { return }
//        toView.alpha = 0
//    }
//
//    private func prepareForZoom(fromView: UIView, toView: UIView) {
//        guard !reverseTransition else { return }
//        toView.alpha = 0
//        toView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//    }
    
    // MARK: - Animation Perform -
    
//    private func performSlide(fromView: UIView, toView: UIView, direction: TransitionDirection) {
//        toView.transform = .identity
//        let multiplier: CGFloat = reverseTransition ? 1 : -1
//        fromView.transform = CGAffineTransform(translationX: 0, y: multiplier * fromView.frame.size.height)
//    }
//
//    private func performZoomPush(fromView: UIView, toView: UIView, direction: TransitionDirection, scale: CGFloat) {
//        toView.transform = .identity
//        let multiplier: CGFloat = reverseTransition ? 1 : -1
//        var transform = CGAffineTransform(translationX: multiplier * toView.frame.size.width, y: 0)
//        transform = transform.scaledBy(x: scale, y: scale)
//        fromView.transform = transform
//    }
//
//    private func performCover(fromView: UIView, toView: UIView, direction: TransitionDirection) {
//        guard reverseTransition else {
//            toView.transform = .identity
//            return }
//        fromView.transform = CGAffineTransform(translationX: 0, y: toView.frame.size.height)
//    }
//
//    private func performPage(fromView: UIView, toView: UIView, direction: TransitionDirection, scale: CGFloat) {
//        toView.transform = .identity
//        guard reverseTransition else {
//            fromView.transform = CGAffineTransform(scaleX: scale, y: scale)
//            return }
//        fromView.transform = CGAffineTransform(translationX: toView.frame.size.width, y: 0)
//    }
//
//    private func performFade(fromView: UIView, toView: UIView) {
//        guard reverseTransition else {
//            toView.alpha = 1
//            return }
//        fromView.alpha = 0
//    }
//
//    private func performZoom(fromView: UIView, toView: UIView) {
//        guard reverseTransition else {
//            toView.transform = .identity
//            toView.alpha = 1
//            return }
//        fromView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//        fromView.alpha = 0
//    }
    
}
