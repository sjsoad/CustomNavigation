//
//  TransitioningDelegate.swift
//  SKUtils
//
//  Created by Sergey Kostyan on 07.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

public typealias PresentationControllerProvider = (_ presented: UIViewController, _ presenting: UIViewController?,
    _ source: UIViewController) -> UIPresentationController?

public protocol TransitioningDelegate: UIViewControllerTransitioningDelegate, AnimationControllerProvider {
    
    init(animatedTransitioning: CustomAnimatedTransitioning?, interactionController: UIViewControllerInteractiveTransitioning?,
         presentationControllerProvider: PresentationControllerProvider?)
}

open class DefaultTransitioningDelegate: NSObject, TransitioningDelegate {
    
    public var animatedTransitioning: CustomAnimatedTransitioning?
    public var interactionController: UIViewControllerInteractiveTransitioning?
    public var presentationControllerProvider: PresentationControllerProvider?
    
    required public init(animatedTransitioning: CustomAnimatedTransitioning? = nil,
                         interactionController: UIViewControllerInteractiveTransitioning? = nil,
                         presentationControllerProvider: PresentationControllerProvider? = nil) {
        self.animatedTransitioning = animatedTransitioning
        self.interactionController = interactionController
        self.presentationControllerProvider = presentationControllerProvider
    }
    
    // MARK: - UIViewControllerTransitioningDelegate -
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        return presentationControllerProvider?(presented, presenting, source)
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
