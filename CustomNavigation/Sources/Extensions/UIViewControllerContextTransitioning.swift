//
//  UIViewControllerContextTransitioning.swift
//  SKCustomNavigation
//
//  Created by Sergey on 05.09.2018.
//

import UIKit

extension UIViewControllerContextTransitioning {
    
    func toView() -> UIView? {
        guard let toView = view(forKey: .to), let toVC = viewController(forKey: .to) else { return nil }
        toView.frame = finalFrame(for: toVC)
        toView.layoutIfNeeded()
        return toView
    }
    
    func addDestinationView(for reverseTransition: Bool) {
        guard let toView = toView() else { return }
        if reverseTransition {
            containerView.insertSubview(toView, at: 0)
        } else {
            containerView.addSubview(toView)
        }
    }
    
    func completeInteraction(_ didComplete: Bool) {
        guard didComplete else {
            cancelInteractiveTransition()
            return }
        finishInteractiveTransition()
    }
    
}
