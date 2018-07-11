//
//  SubviewsAnimationProvider.swift
//  AERecord
//
//  Created by Sergey on 11.07.2018.
//

import UIKit

open class SubviewsAnimationProvider: NSObject {

    private var fromVC: UIViewController?
    private var toVC: UIViewController?
    private var container: UIView
    private var fromSnapshots: [UIView] = []
    private var toSnapshots: [UIView] = []
    private var frames: [(from: CGRect, to: CGRect)] = []
    
    public init(transitionContext: UIViewControllerContextTransitioning) {
        fromVC = transitionContext.viewController(forKey: .from)
        toVC   = transitionContext.viewController(forKey: .to)
        container = transitionContext.containerView
    }
    
    // MARK: - Private -
    
    func snapshots(from provider: SubviewsForAnimatiedTransitionProvider, afterScreenUpdates: Bool) -> [UIView] {
        let snapshots = provider.viewsToAnimate.compactMap { subview -> UIView? in
            guard let snapshot = subview.snapshotView(afterScreenUpdates: afterScreenUpdates) else { return nil }
            snapshot.frame = container.convert(subview.frame, from: subview.superview)
            return snapshot
        }
        return snapshots
    }
    
    // MARK: - Public  -
    
    public func prepareForAnimation() {
        toVC?.view.layoutIfNeeded()
        guard let toVC = toVC as? SubviewsForAnimatiedTransitionProvider,
            let fromVC = fromVC as? SubviewsForAnimatiedTransitionProvider else { return }
        fromSnapshots = snapshots(from: fromVC, afterScreenUpdates: false)
        toSnapshots = snapshots(from: toVC, afterScreenUpdates: true)
        
        frames = zip(fromSnapshots, toSnapshots).map { (from: $0.frame, to: $1.frame) }
        zip(toSnapshots, frames).forEach { snapshot, frame in
            snapshot.frame = frame.from
            snapshot.alpha = 0
            container.addSubview(snapshot)
        }
        fromSnapshots.forEach { container.addSubview($0) }
        fromVC.viewsToAnimate.forEach { $0.isHidden = true }
        DispatchQueue.main.async {
            toVC.viewsToAnimate.forEach { $0.isHidden = true }
        }
    }
    
    public func performAnimation() {
        zip(toSnapshots, frames).forEach { snapshot, frame in
            snapshot.frame = frame.to
            snapshot.alpha = 1
        }
        
        zip(fromSnapshots, frames).forEach { snapshot, frame in
            snapshot.frame = frame.to
            snapshot.alpha = 0
        }
    }
    
    public func completeAnimation() {
        guard let toVC = toVC as? SubviewsForAnimatiedTransitionProvider,
            let fromVC = fromVC as? SubviewsForAnimatiedTransitionProvider else { return }
        fromSnapshots.forEach { $0.removeFromSuperview() }
        toSnapshots.forEach   { $0.removeFromSuperview() }
        fromVC.viewsToAnimate.forEach { $0.isHidden = false }
        toVC.viewsToAnimate.forEach { $0.isHidden = false }
    }
    
}
