//
//  DefaultTransitioningDelegate.swift
//  SKUtils
//
//  Created by Sergey Kostyan on 07.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class DefaultTransitioningDelegate: NSObject, TransitioningDelegate {
    
    public var animatedTransitioning: CustomAnimatedTransitioning?
    open var interactionController: InteractionControlling?
    public var presentationControllerProvider: PresentationControllerProvider?
    
    public required init(animatedTransitioning: CustomAnimatedTransitioning? = nil,
                         interactionController: InteractionControlling? = nil,
                         presentationControllerProvider: PresentationControllerProvider? = nil) {
        self.animatedTransitioning = animatedTransitioning
        self.presentationControllerProvider = presentationControllerProvider
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
