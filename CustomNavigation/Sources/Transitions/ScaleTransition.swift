//
//  ScaleTransition.swift
//  SKCustomNavigation
//
//  Created by Sergey on 05.09.2018.
//

import Foundation
import SKAnimator

open class ScaleTransition: DirectionalTransition {
    
    public private(set) var scale: CGFloat
    
    public init(scale: CGFloat = defaultScale, transitionDirection: TransitionDirection = .fromTop,
                animatorProvider: AnimatorProvider = DefaultAnimatorProvider()) {
        self.scale = scale
        super.init(transitionDirection: transitionDirection, animatorProvider: animatorProvider)
    }
    
}
