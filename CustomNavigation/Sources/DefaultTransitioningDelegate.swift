//
//  DefaultTransitioningDelegate.swift
//  SKUtils
//
//  Created by Sergey Kostyan on 07.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

// For modal transitions or presentation

open class DefaultTransitioningDelegate: NSObject, TransitioningDelegate {
    
    public var animatedTransitioning: CustomAnimatedTransitioning?
    public var presentationControllerProvider: PresentationControllerProvider?
    public var interactionController: InteractionController?
    
    public required init(animatedTransitioning: CustomAnimatedTransitioning? = nil,
                         presentationControllerProvider: PresentationControllerProvider? = nil,
                         interactionController: InteractionController? = nil) {
        self.animatedTransitioning = animatedTransitioning
        self.presentationControllerProvider = presentationControllerProvider
        self.interactionController = interactionController
        interactionController?.interactionDelegate = animatedTransitioning
    }
    
    // MARK: - UIViewControllerTransitioningDelegate -
    
    open func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController?.interactionInProgress == true ? interactionController : nil
    }
    
    open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        return presentationControllerProvider?(presented, presenting, source)
    }
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransitioning?.reverseTransition = false
        return animatedTransitioning
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransitioning?.reverseTransition = true
        return animatedTransitioning
    }
    
}
