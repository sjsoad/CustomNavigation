//
//  NavigationController.swift
//  SKUtils
//
//  Created by Sergey on 07.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

public protocol InteractiveNavigation {
    
    var isInteractive: Bool { get }
    func set(interactive: Bool)
    
}

open class DefaultNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate, InteractiveNavigation {
    
    open var interactionController: InteractionControlling?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        // Do any additional setup after loading the view.
    }

    // MARK: - InteractiveNavigation -
    
    public var isInteractive: Bool {
        return interactivePopGestureRecognizer?.isEnabled ?? false
    }
    
    public func set(interactive: Bool) {
        interactivePopGestureRecognizer?.isEnabled = interactive
        interactivePopGestureRecognizer?.delegate = interactive ? self : nil
    }
    
    // MARK: - UINavigationControllerDelegate -
    
    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            interactionController?.viewController = navigationController.topViewController
            return interactionController?.interactionInProgress == true ? interactionController : nil
    }
    
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation,
                                   from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let sourceVC = operation == .push ? fromVC : toVC
        guard let animationControllerProvider = sourceVC as? AnimationControllerProvider,
        let animatedTransitioning = animationControllerProvider.animatedTransitioning else { return nil }
        animatedTransitioning.reverseTransition = operation != .push
        return animatedTransitioning
    }
    
    // MARK: - UIGestureRecognizerDelegate -
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
