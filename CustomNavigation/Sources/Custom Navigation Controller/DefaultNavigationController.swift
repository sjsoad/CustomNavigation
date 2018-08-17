//
//  NavigationController.swift
//  SKUtils
//
//  Created by Sergey on 07.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class DefaultNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate,
DefaultInteractiveNavigation {
    
    public private(set) var interactionController: InteractionControlling? {
        didSet {
            // TODO: - fix interaction controllers for different top viewControllers -
            print(interactionController ?? "no interactionController")
            print(oldValue ?? "no oldValue")
            interactionController?.activate()
            guard (oldValue === interactionController) == false else {
                return }
            oldValue?.deactivate()
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        // Do any additional setup after loading the view.
    }

    // MARK: - InteractiveNavigation -
    
    public var isDefaultInteractionEnabled: Bool {
        return interactivePopGestureRecognizer?.isEnabled ?? false
    }
    
    public func set(defaultInteractionEnabled: Bool) {
        interactivePopGestureRecognizer?.isEnabled = defaultInteractionEnabled
        interactivePopGestureRecognizer?.delegate = defaultInteractionEnabled ? self : nil
    }
    
    // MARK: - UINavigationControllerDelegate -
    
    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return interactionController?.interactionInProgress == true ? interactionController : nil
    }
    
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation,
                                   from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var animationControllerProvider = toVC as? AnimationControllerProvider
        if operation == .push {
           animationControllerProvider = fromVC as? AnimationControllerProvider
        }
        let animatedTransitioning = animationControllerProvider?.animatedTransitioning
        animatedTransitioning?.reverseTransition = operation != .push
        interactionController = animatedTransitioning?.interactionController
        return animatedTransitioning
    }
    
    // MARK: - UIGestureRecognizerDelegate -
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
