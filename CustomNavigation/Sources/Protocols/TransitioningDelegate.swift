//
//  TransitioningDelegate.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 29.06.2018.
//

import UIKit

public protocol TransitioningDelegate: UIViewControllerTransitioningDelegate, AnimationControllerProvider {
    
    init(animatedTransitioning: CustomAnimatedTransitioning?, interactionController: InteractionControlling?,
         presentationControllerProvider: PresentationControllerProvider?)
}
