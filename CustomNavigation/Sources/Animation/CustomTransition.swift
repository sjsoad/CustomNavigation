//
//  CustomTransition.swift
//  SKUtils
//
//  Created by Sergey on 25.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import Foundation
import SKCustomNavigation

enum TransitionDirection {
    case fromTop
    case fromLeft
    case fromRight
    case fromBottom
}

enum TransitionType {
    case push
    case slide
    case zoomPush(scale: CGFloat)
    case cover
    case page(scale: CGFloat)
    case fade
    case zoom
}

class CustomTransition: NSObject, CustomAnimatedTransitioning {
    
    var duration: TimeInterval
    var reverseTransition: Bool
    var transitionType: TransitionType
    
    var pushDelta: CGFloat = 0.2 // How much bottom view will be moved on push
    
    init(duration: TimeInterval = 0.5, reverseTransition: Bool = false, transitionType: TransitionType) {
        self.duration = duration
        self.reverseTransition = reverseTransition
        self.transitionType = transitionType
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning -
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        reverseTransition == false ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        prepareForAnimation(fromView: fromView, toView: toView)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { [weak self] in
            self?.performAnimation(fromView: fromView, toView: toView)
            }, completion: { [weak self] (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                self?.animationFinished()
                self?.completeTransition(fromView: fromView, toView: toView)
        })
    }
    
    // MARK: - Private -
    
    private func prepareForAnimation(fromView: UIView, toView: UIView) {
        switch transitionType {
        case .push:
            guard reverseTransition else {
                toView.transform = CGAffineTransform(translationX: fromView.frame.size.width, y: 0)
                return }
            toView.transform = CGAffineTransform(translationX: -fromView.frame.size.width * pushDelta, y: 0)
        case .slide:
            let multiplier: CGFloat = reverseTransition ? -1 : 1
            toView.transform = CGAffineTransform(translationX: 0, y: multiplier * toView.bounds.size.height)
        case .zoomPush(let scale):
            let multiplier: CGFloat = reverseTransition ? -1 : 1
            var transform = CGAffineTransform(translationX: multiplier * toView.bounds.size.width, y: 0)
            transform = transform.scaledBy(x: scale, y: scale)
            toView.transform = transform
        case .cover:
            guard !reverseTransition else { return }
            toView.transform = CGAffineTransform(translationX: 0, y: toView.bounds.size.height)
        case .page(let scale):
            guard reverseTransition else {
                toView.transform = CGAffineTransform(translationX: toView.bounds.size.width, y: 0)
                return }
            toView.transform = CGAffineTransform(scaleX: scale, y: scale)
        case .fade:
            guard !reverseTransition else { return }
            toView.alpha = 0
        case .zoom:
            guard !reverseTransition else { return }
            toView.alpha = 0
            toView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }
    }
    
    private func performAnimation(fromView: UIView, toView: UIView) {
        switch transitionType {
        case .push:
            toView.transform = .identity
            guard reverseTransition else {
                fromView.transform = CGAffineTransform(translationX: -fromView.frame.size.width * pushDelta, y: 0)
                return }
            fromView.transform = CGAffineTransform(translationX: fromView.frame.size.width, y: 0)
        case .slide:
            toView.transform = .identity
            let multiplier: CGFloat = reverseTransition ? 1 : -1
            fromView.transform = CGAffineTransform(translationX: 0, y: multiplier * fromView.bounds.size.height)
        case .zoomPush(let scale):
            toView.transform = .identity
            let multiplier: CGFloat = reverseTransition ? 1 : -1
            var transform = CGAffineTransform(translationX: multiplier * toView.bounds.size.width, y: 0)
            transform = transform.scaledBy(x: scale, y: scale)
            fromView.transform = transform
        case .cover:
            guard reverseTransition else {
                toView.transform = .identity
                return }
            fromView.transform = CGAffineTransform(translationX: 0, y: toView.bounds.size.height)
        case .page(let scale):
            toView.transform = .identity
            guard reverseTransition else {
                fromView.transform = CGAffineTransform(scaleX: scale, y: scale)
                return }
            fromView.transform = CGAffineTransform(translationX: toView.bounds.size.width, y: 0)
        case .fade:
            guard reverseTransition else {
                toView.alpha = 1
                return }
            fromView.alpha = 0
        case .zoom:
            guard reverseTransition else {
                toView.transform = .identity
                toView.alpha = 1
                return }
            fromView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            fromView.alpha = 0
        }
    }
    
    private func completeTransition(fromView: UIView, toView: UIView) {
        toView.alpha = 1
        fromView.alpha = 1
        toView.transform = .identity
        fromView.transform = .identity
    }
    
}
