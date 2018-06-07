//
//  TransitioningDelegate.swift
//  SKUtils
//
//  Created by Sergey Kostyan on 07.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

public protocol TransitioningDelegate: UIViewControllerTransitioningDelegate, AnimationControllerProvider {
    
    init(animatedTransitioning: CustomAnimatedTransitioning?, interactionController: UIViewControllerInteractiveTransitioning?)
    
}

open class DefaultTransitioningDelegate: NSObject, TransitioningDelegate {

    public var animatedTransitioning: CustomAnimatedTransitioning?
    public var interactionController: UIViewControllerInteractiveTransitioning?
    
    required public init(animatedTransitioning: CustomAnimatedTransitioning?, interactionController: UIViewControllerInteractiveTransitioning? = nil) {
        self.animatedTransitioning = animatedTransitioning
    }
    
    // MARK: - UIViewControllerTransitioningDelegate -
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransitioning?.reverseTransition = false
        return animatedTransitioning
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransitioning?.reverseTransition = true
        return animatedTransitioning
    }
    
}
