//
//  SubviewsMathingAnimationProvider.swift
//  AERecord
//
//  Created by Sergey on 11.07.2018.
//

import UIKit

open class SubviewsMathingAnimationProvider: SubviewsMatchingAnimatable {
    
//    private var container: UIView!
//    private var subviewIdToSourceView: [String: UIView] = [:]
//    private var subviewIdToDestinationView: [String: UIView] = [:]
//    private var snapshotViews: [UIView: UIView] = [:]
//    private var viewsAlpha: [UIView: CGFloat] = [:]
//    private var viewsRect: [UIView: CGRect] = [:]
    
    private var viewPairs: [SubviewsPair] = []
    private var snapshotPairs: [SubviewsPair] = []
    
    public init?(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
        let toView = transitionContext.view(forKey: .to),
        fromView.subviewsMathing, toView.subviewsMathing else { return nil }
        viewPairs = gatherPairs(fromView, and: toView)
    }
    
    // MARK: - Private -
    
    private func gatherPairs(_ fromView: UIView, and toView: UIView) -> [SubviewsPair] {
        return fromView.flattenSubviews.compactMap { (sourceView) -> SubviewsPair? in
            guard let subviewId = sourceView.subviewId,
                let destinationView = toView.flattenSubviews.first(where: { $0.subviewId == subviewId }) else { return nil }
            return (from: sourceView.subview, to: destinationView.subview)
        }
    }
    
    // №1 берем вью и делаем снэпшоты
    // №2 присвоить правильный фрейм и добавить на контейнер
    // №3 спрятать оригинальные вью
    // №4 анимация
    // №5 востановить оригинальные вью и удалить снэпшоты
    
//    private func process(views: [UIView], idMap: inout [String: UIView]) {
//        for view in views {
//            if let subviewID = view.subviewId {
//                idMap[subviewID] = view
//            }
//            process(views: view.subviews, idMap: &idMap)
//        }
//    }
//
//    private func sourceView(for subviewId: String) -> UIView? {
//        return subviewIdToSourceView[subviewId]
//    }
//
//    private func destinationView(for subviewId: String) -> UIView? {
//        return subviewIdToDestinationView[subviewId]
//    }
//
//    private func snapshot(for view: UIView) -> UIView {
//        let snapshot = view.imageView()
//        snapshot.frame = container.convert(view.frame, from: view.superview)
//        viewsAlpha[view] = view.alpha
//        snapshotViews[view] = snapshot
//        viewsRect[view] = snapshot.frame
//        return snapshot
//    }
//
//    private func returnOriginalAlpha(for views: [UIView]) {
//        views.forEach { (view) in
//            guard let alpha = viewsAlpha[view] else { return }
//            view.alpha = alpha
//        }
//    }
//
//    private func applyAlpha(of source: UIView, to snapshot: UIView) {
//        guard let alpha = viewsAlpha[source] else { return }
//        snapshot.alpha = alpha
//    }
//
//    private func hide(_ view: UIView) {
//        view.alpha = 0
//    }
//
//    private func applyFrame(of source: UIView, to snapshot: UIView) {
//        guard let frame = viewsRect[source] else { return }
//        snapshot.frame = frame
//    }
//
//    private func removeSnapshots() {
//        snapshotViews.values.forEach { (snapshot) in
//            snapshot.removeFromSuperview()
//        }
//    }
    
    // MARK: - Public  -
    
    public func prepareForAnimation() {
        viewPairs.forEach { (from, to) in
        }
//        subviewIdToSourceView.keys.forEach { (subviewId) in
//            guard let sourceView = sourceView(for: subviewId), let destinationView = destinationView(for: subviewId) else { return }
//            let sourceSnapshot = snapshot(for: sourceView)
//            let destinationSnapshot = snapshot(for: destinationView)
//            applyFrame(of: sourceView, to: destinationSnapshot)
//            hide(destinationSnapshot)
//            container.addSubview(destinationSnapshot)
//            container.addSubview(sourceSnapshot)
//            hide(sourceView)
//            hide(destinationView)
//        }
    }
    
    public func performAnimation() {
//        subviewIdToSourceView.keys.forEach { (subviewId) in
//            guard let sourceView = sourceView(for: subviewId), let destinationView = destinationView(for: subviewId) else { return }
//            if let destinationSnapshot = snapshotViews[destinationView]  {
//                applyFrame(of: destinationView, to: destinationSnapshot)
//                applyAlpha(of: destinationView, to: destinationSnapshot)
//                if let sourceSnapshot = snapshotViews[sourceView] {
//                    applyFrame(of: destinationView, to: sourceSnapshot)
//                    hide(sourceSnapshot)
//                }
//            }
//        }
    }
    
    public func completeAnimation() {
        viewPairs.forEach { (from, to) in
        }
    }
    
}
