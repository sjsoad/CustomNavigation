//
//  DefaultNavigationControllerDelegate.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 19.08.2018.
//

import UIKit

// For navigation transitions

open class DefaultNavigationControllerDelegate: NSObject, InteractionControllerProvider, UINavigationControllerDelegate {
    
    open var interactionController: InteractionControlling?
    
    public init(with interactionController: InteractionControlling? = nil) {
        self.interactionController = interactionController
    }
    
    // MARK: - UINavigationControllerDelegate -
    
    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return interactionController?.interactionInProgress == true ? interactionController : nil
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationControllerOperation,
                                     from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let sourceVC = operation == .push ? fromVC : toVC
        var animationControllerProvider = sourceVC as? AnimationControllerProvider
        let animatedTransitioning = animationControllerProvider?.animatedTransitioning
        animatedTransitioning?.reverseTransition = operation != .push
        interactionController?.interactionDelegate = animatedTransitioning
        return animatedTransitioning
    }
    
}
