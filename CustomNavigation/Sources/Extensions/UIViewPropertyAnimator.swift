//
//  UIViewPropertyAnimator.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 19.08.2018.
//

import Foundation

public extension UIViewPropertyAnimator {
    
    var durationFactor: CGFloat {
        let animationDuration = CGFloat(duration)
        return animationDuration - animationDuration * fractionComplete
    }
    
    func continueAnimation() {
        continueAnimation(withTimingParameters: timingParameters, durationFactor: durationFactor)
    }
    
}
