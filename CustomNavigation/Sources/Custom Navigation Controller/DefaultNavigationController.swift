//
//  NavigationController.swift
//  SKUtils
//
//  Created by Sergey on 07.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class DefaultNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    open var interactionController: InteractionControlling?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    // MARK: - UINavigationControllerDelegate -
    
    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return interactionController?.interactionInProgress == true ? interactionController : nil
    }
    
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation,
                                   from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let sourceVC = operation == .push ? fromVC : toVC
        var animationControllerProvider = sourceVC as? AnimationControllerProvider
        let animatedTransitioning = animationControllerProvider?.animatedTransitioning
        animatedTransitioning?.reverseTransition = operation != .push
        interactionController?.interactionDelegate = animatedTransitioning
        return animatedTransitioning
    }
    
    // MARK: - UIGestureRecognizerDelegate -
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
