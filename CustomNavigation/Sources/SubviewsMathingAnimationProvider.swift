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
        guard let fromView = transitionContext.view(forKey: .from),
        let toView = transitionContext.view(forKey: .to),
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
            let toSnapshot = to.snapshot
            let fromSnapshot = from.snapshot
            from.hideOriginal()
            to.hideOriginal()
            toSnapshot.frame = from.convertedFrame
            container.addSubview(toSnapshot)
            container.addSubview(fromSnapshot)
        }
    }
    
    public func performAnimation() {
        viewPairs.forEach { (from, to) in
            let toSnapshot = to.snapshot
            let fromSnapshot = from.snapshot
            let fromZPosition = fromSnapshot.layer.zPosition
            let toZPosition = toSnapshot.layer.zPosition
            fromSnapshot.frame = to.convertedFrame
            toSnapshot.frame = to.convertedFrame
            fromSnapshot.layer.zPosition = toZPosition
            toSnapshot.layer.zPosition = fromZPosition
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
