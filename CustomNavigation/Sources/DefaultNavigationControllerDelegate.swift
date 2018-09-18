//
//  DefaultNavigationControllerDelegate.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 19.08.2018.
//

import UIKit

// For navigation transitions

open class DefaultNavigationControllerDelegate: NSObject, NavigationControllerDelegate {
    
    open var interactionController: InteractionController?
    
    public init(with interactionController: InteractionController? = nil) {
        self.interactionController = interactionController
    }
    
    // MARK: - UINavigationControllerDelegate -
    
    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return interactionController?.interactionInProgress == true ? interactionController : nil
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
                                     from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let sourceVC = sourceViewController(for: operation, from: fromVC, to: toVC)
        guard let animatedTransitioning = animatedTransitioning(from: sourceVC)  else { return nil }
        animatedTransitioning.reverseTransition = reverseTransition(with: operation)
        interactionController?.interactionDelegate = animatedTransitioning
        return animatedTransitioning
    }
    
    // MARK: - Private -
    
    private func sourceViewController(for operation: UINavigationController.Operation, from fromVC: UIViewController,
                                      to toVC: UIViewController) -> UIViewController {
        return operation == .push ? fromVC : toVC
    }
    
    private func animatedTransitioning(from viewController: UIViewController) -> CustomAnimatedTransitioning? {
        guard let animationControllerProvider = viewController as? AnimationControllerProvider,
            let animatedTransitioning = animationControllerProvider.animatedTransitioning else { return nil }
        return animatedTransitioning
    }
    
    private func reverseTransition(with operation: UINavigationController.Operation) -> Bool {
        return operation != .push
    }
    
}
