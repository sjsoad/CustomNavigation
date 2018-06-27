//
//  CustomTransition.swift
//  SKUtils
//
//  Created by Sergey on 25.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import Foundation

public enum TransitionDirection {
    case fromTop
    case fromLeft
    case fromRight
    case fromBottom
}

public enum TransitionType {
    case push(direction: TransitionDirection)
    case slide(direction: TransitionDirection)
    case zoomPush(direction: TransitionDirection, scale: CGFloat)
    case cover(direction: TransitionDirection)
    case page(direction: TransitionDirection, scale: CGFloat)
    case fade
    case zoom
}

open class CustomTransition: NSObject, CustomAnimatedTransitioning {
    
    open var duration: TimeInterval
    open var reverseTransition: Bool
    open var transitionType: TransitionType
    
    open var pushDelta: CGFloat = 0.2 // How much bottom view will be moved on push
    
    public init(duration: TimeInterval = 0.5, reverseTransition: Bool = false, transitionType: TransitionType) {
        self.duration = duration
        self.reverseTransition = reverseTransition
        self.transitionType = transitionType
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning -
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        toView.frame = fromView.frame
        reverseTransition == false ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        prepareForAnimation(fromView: fromView, toView: toView)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { [weak self] in
            self?.performAnimation(fromView: fromView, toView: toView)
            }, completion: { [weak self] (_) in
                self?.animationFinished()
                self?.completeTransition(fromView: fromView, toView: toView)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    // MARK: - Private -
    
    // MARK: - Utils -
    
    private func xPoint(for view: UIView, direction: TransitionDirection) -> CGFloat {
        let multiplier: CGFloat = reverseTransition ? -1 : 1
        switch direction {
        case .fromRight:
            return view.frame.size.width * multiplier
        case .fromLeft:
            return -view.frame.size.width * multiplier
        default:
            return 0
        }
    }
    
    private func yPoint(for view: UIView, direction: TransitionDirection) -> CGFloat {
        let multiplier: CGFloat = reverseTransition ? -1 : 1
        switch direction {
        case .fromTop:
            return -view.frame.size.height * multiplier
        case .fromBottom:
            return view.frame.size.height * multiplier
        default:
            return 0
        }
    }
    
    // MARK: - Animation Preparetion -
    
    private func prepareForPush(fromView: UIView, toView: UIView, direction: TransitionDirection) {
        let yPosition = yPoint(for: toView, direction: direction)
        let xPosition = xPoint(for: toView, direction: direction)
        guard reverseTransition else {
            toView.transform = CGAffineTransform(translationX: xPosition, y: yPosition)
            return }
        toView.transform = CGAffineTransform(translationX: xPosition/* * pushDelta*/, y: yPosition)
    }
    
    private func prepareForSlide(fromView: UIView, toView: UIView, direction: TransitionDirection) {
        let multiplier: CGFloat = reverseTransition ? -1 : 1
        toView.transform = CGAffineTransform(translationX: 0, y: multiplier * toView.frame.size.height)
    }
    
    private func prepareForZoomPush(fromView: UIView, toView: UIView, direction: TransitionDirection, scale: CGFloat) {
        let multiplier: CGFloat = reverseTransition ? -1 : 1
        var transform = CGAffineTransform(translationX: multiplier * toView.frame.size.width, y: 0)
        transform = transform.scaledBy(x: scale, y: scale)
        toView.transform = transform
    }

    private func prepareForCover(fromView: UIView, toView: UIView, direction: TransitionDirection) {
        guard !reverseTransition else { return }
        toView.transform = CGAffineTransform(translationX: 0, y: toView.frame.size.height)
    }
    
    private func prepareForPage(fromView: UIView, toView: UIView, direction: TransitionDirection, scale: CGFloat) {
        guard reverseTransition else {
            toView.transform = CGAffineTransform(translationX: toView.frame.size.width, y: 0)
            return }
        toView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    private func prepareForFade(fromView: UIView, toView: UIView) {
        guard !reverseTransition else { return }
        toView.alpha = 0
    }
    
    private func prepareForZoom(fromView: UIView, toView: UIView) {
        guard !reverseTransition else { return }
        toView.alpha = 0
        toView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
    
    // MARK: - Animation Perform -
    
    private func performPush(fromView: UIView, toView: UIView, direction: TransitionDirection) {
        let yPosition = yPoint(for: toView, direction: direction)
        let xPosition = xPoint(for: toView, direction: direction)
        toView.transform = .identity
        guard reverseTransition else {
            fromView.transform = CGAffineTransform(translationX: xPosition/* * pushDelta*/, y: yPosition)
            return }
        fromView.transform = CGAffineTransform(translationX: xPosition, y: yPosition)
    }
    
    private func performSlide(fromView: UIView, toView: UIView, direction: TransitionDirection) {
        toView.transform = .identity
        let multiplier: CGFloat = reverseTransition ? 1 : -1
        fromView.transform = CGAffineTransform(translationX: 0, y: multiplier * fromView.frame.size.height)
    }
    
    private func performZoomPush(fromView: UIView, toView: UIView, direction: TransitionDirection, scale: CGFloat) {
        toView.transform = .identity
        let multiplier: CGFloat = reverseTransition ? 1 : -1
        var transform = CGAffineTransform(translationX: multiplier * toView.frame.size.width, y: 0)
        transform = transform.scaledBy(x: scale, y: scale)
        fromView.transform = transform
    }
    
    private func performCover(fromView: UIView, toView: UIView, direction: TransitionDirection) {
        guard reverseTransition else {
            toView.transform = .identity
            return }
        fromView.transform = CGAffineTransform(translationX: 0, y: toView.frame.size.height)
    }

    private func performPage(fromView: UIView, toView: UIView, direction: TransitionDirection, scale: CGFloat) {
        toView.transform = .identity
        guard reverseTransition else {
            fromView.transform = CGAffineTransform(scaleX: scale, y: scale)
            return }
        fromView.transform = CGAffineTransform(translationX: toView.frame.size.width, y: 0)
    }
    
    private func performFade(fromView: UIView, toView: UIView) {
        guard reverseTransition else {
            toView.alpha = 1
            return }
        fromView.alpha = 0
    }
    
    private func performZoom(fromView: UIView, toView: UIView) {
        guard reverseTransition else {
            toView.transform = .identity
            toView.alpha = 1
            return }
        fromView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        fromView.alpha = 0
    }
    
    // MARK: - Switch -
    
    private func prepareForAnimation(fromView: UIView, toView: UIView) {
        switch transitionType {
        case .push(let direction):
            prepareForPush(fromView: fromView, toView: toView, direction: direction)
        case .slide(let direction):
            prepareForSlide(fromView: fromView, toView: toView, direction: direction)
        case .zoomPush(let direction, let scale):
            prepareForZoomPush(fromView: fromView, toView: toView, direction: direction, scale: scale)
        case .cover(let direction):
            prepareForCover(fromView: fromView, toView: toView, direction: direction)
        case .page(let direction, let scale):
           prepareForPage(fromView: fromView, toView: toView, direction: direction, scale: scale)
        case .fade:
            prepareForFade(fromView: fromView, toView: toView)
        case .zoom:
            prepareForZoom(fromView: fromView, toView: toView)
        }
    }
    
    private func performAnimation(fromView: UIView, toView: UIView) {
        switch transitionType {
        case .push(let direction):
            performPush(fromView: fromView, toView: toView, direction: direction)
        case .slide(let direction):
            performSlide(fromView: fromView, toView: toView, direction: direction)
        case .zoomPush(let direction, let scale):
            performZoomPush(fromView: fromView, toView: toView, direction: direction, scale: scale)
        case .cover(let direction):
            performCover(fromView: fromView, toView: toView, direction: direction)
        case .page(let direction, let scale):
            performPage(fromView: fromView, toView: toView, direction: direction, scale: scale)
        case .fade:
            performFade(fromView: fromView, toView: toView)
        case .zoom:
            performZoom(fromView: fromView, toView: toView)
        }
    }
    
    private func completeTransition(fromView: UIView, toView: UIView) {
        toView.alpha = 1
        fromView.alpha = 1
        toView.transform = .identity
        fromView.transform = .identity
    }
    
}
