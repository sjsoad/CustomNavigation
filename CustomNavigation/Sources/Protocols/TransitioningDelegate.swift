//
//  TransitioningDelegate.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 29.06.2018.
//

import UIKit

public protocol TransitioningDelegate: UIViewControllerTransitioningDelegate, InteractionControllerProvider, AnimationControllerProvider {
    
    var presentationControllerProvider: PresentationControllerProvider? { get set }
    
    init(animatedTransitioning: CustomAnimatedTransitioning?, presentationControllerProvider: PresentationControllerProvider?,
         interactionController: InteractionControlling?)
}
