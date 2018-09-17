//
//  SubviewsMathingAnimationProvider.swift
//  AERecord
//
//  Created by Sergey on 11.07.2018.
//

import UIKit

open class SubviewsMathingAnimationProvider: SubviewsMatchingAnimatable {
    
    private var container: UIView
    private var viewPairs: [SubviewsPair] = []
    
    public init?(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewController(forKey: .from)?.view,
        let toView = transitionContext.viewController(forKey: .to)?.view,
        fromView.subviewsMathing, toView.subviewsMathing else { return nil }
        container = transitionContext.containerView
        viewPairs = gatherPairs(in: fromView, and: toView, with: transitionContext.containerView)
    }
    
    // MARK: - Private -
    
    private func gatherPairs(in fromView: UIView, and toView: UIView, with container: UIView) -> [SubviewsPair] {
        return fromView.flattenSubviews.compactMap { (sourceView) -> SubviewsPair? in
            guard let subviewId = sourceView.subviewId,
                let destinationView = toView.flattenSubviews.first(where: { $0.subviewId == subviewId }) else { return nil }
            let animatableSource = AnimatableSubview(with: sourceView, and: container)
            let animatableDestination = AnimatableSubview(with: destinationView, and: container)
            return (from: animatableSource, to: animatableDestination)
        }
    }
    
    // MARK: - Public  -
    
    public func prepareForAnimation() {
        viewPairs.forEach { (from, to) in
            from.hideOriginal()
            to.hideOriginal()
            to.snapshot.frame = from.convertedFrame
            from.snapshot.frame = from.convertedFrame
            container.addSubview(to.snapshot)
            container.addSubview(from.snapshot)
        }
    }
    
    public func performAnimation() {
        viewPairs.forEach { (from, to) in
            to.snapshot.frame = to.convertedFrame
            from.snapshot.frame = to.convertedFrame
            from.snapshot.alpha = 0
        }
    }
    
    public func completeAnimation() {
        viewPairs.forEach { (from, to) in
            from.restore()
            to.restore()
        }
        viewPairs.removeAll()
    }
    
}
