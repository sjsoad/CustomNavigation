//
//  SubviewsAnimationProvider.swift
//  AERecord
//
//  Created by Sergey on 11.07.2018.
//

import UIKit

open class SubviewsAnimationProvider: NSObject {

    private var container: UIView!
    private var subviewIdToSourceView: [String: UIView] = [:]
    private var subviewIdToDestinationView: [String: UIView] = [:]
    private var snapshotViews: [UIView: UIView] = [:]
    private var viewAlphas: [UIView: CGFloat] = [:]
    
    public init(transitionContext: UIViewControllerContextTransitioning) {
        super.init()
        container = transitionContext.containerView
        if let sourceVC = transitionContext.viewController(forKey: .from),
            let destinationVC   = transitionContext.viewController(forKey: .to) {
            sourceVC.view.layoutIfNeeded()
            process(views: sourceVC.view.subviews, idMap: &subviewIdToSourceView)
            process(views: destinationVC.view.subviews, idMap: &subviewIdToDestinationView)
        }
    }
    
    // MARK: - Private -
    
    private func process(views: [UIView], idMap: inout [String: UIView]) {
        for view in views {
            process(views: view.subviews, idMap: &idMap)
            guard let subviewID = view.subviewId else { return }
            idMap[subviewID] = view
        }
    }
    
    private func sourceView(for subviewId: String) -> UIView? {
        return subviewIdToSourceView[subviewId]
    }

    private func destinationView(for subviewId: String) -> UIView? {
        return subviewIdToDestinationView[subviewId]
    }
    
    private func snapshot(for view: UIView) -> UIView {
        let snapshot = view.slowSnapshotView()
        snapshot.frame = container.convert(view.frame, from: view.superview)
        viewAlphas[view] = view.alpha
        snapshotViews[view] = snapshot
        return snapshot
    }
    
    private func returnOriginalAlpha(for views: [UIView]) {
        views.forEach { (view) in
            guard let alpha = viewAlphas[view] else { return }
            view.alpha = alpha
        }
    }
    
    // MARK: - Public  -
    
    public func prepareForAnimation() {
        subviewIdToSourceView.keys.forEach { (subviewId) in
            guard let sourceView = sourceView(for: subviewId), let destinationView = destinationView(for: subviewId) else { return }
            let sourceSnapshot = snapshot(for: sourceView)
            let destinationSnapshot = snapshot(for: destinationView)
            destinationSnapshot.frame = sourceView.frame
            destinationSnapshot.alpha = 0
            container.addSubview(destinationSnapshot)
            container.addSubview(sourceSnapshot)
            sourceView.alpha = 0
            destinationView.alpha = 0
        }
    }
    
    public func performAnimation() {
        subviewIdToSourceView.keys.forEach { (subviewId) in
            guard let sourceView = sourceView(for: subviewId), let destinationView = destinationView(for: subviewId) else { return }
            if let snapshot = snapshotViews[destinationView], let alpha = viewAlphas[destinationView] {
                snapshot.frame = destinationView.frame
                snapshot.alpha = alpha
            }
            if let snapshot = snapshotViews[sourceView] {
                snapshot.frame = destinationView.frame
                snapshot.alpha = 0
            }
        }
    }
    
    public func completeAnimation() {
        snapshotViews.values.forEach { (snapshot) in
            snapshot.removeFromSuperview()
        }
        returnOriginalAlpha(for: subviewIdToSourceView.values.compactMap({ $0 }))
        returnOriginalAlpha(for: subviewIdToDestinationView.values.compactMap({ $0 }))
    }
    
}

private extension UIView {
    
    func slowSnapshotView() -> UIView {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return UIView()
        }
        layer.render(in: currentContext)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageView = UIImageView(image: image)
        imageView.frame = bounds
        return imageView
    }
    
}
