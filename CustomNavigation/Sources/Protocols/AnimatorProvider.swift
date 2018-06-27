//
//  AnimatorProvider.swift
//  SKUtils
//
//  Created by Sergey on 19.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit
import Foundation

public protocol AnimatorProvider {

    var duration: TimeInterval { get }
    func animator() -> UIViewPropertyAnimator
    
}

open class DefaultAnimatorProvider: AnimatorProvider {
    
    public private(set) var duration: TimeInterval
    private var curve: UIViewAnimationCurve
    
    public init(duration: TimeInterval = 0.25, curve: UIViewAnimationCurve = .easeInOut) {
        self.duration = duration
        self.curve = curve
    }
    
    public func animator() -> UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: duration, curve: curve, animations: nil)
        return animator
    }
    
}

open class SpringAnimatorProvider: AnimatorProvider {
    
    public private(set) var duration: TimeInterval
    private var dampingRatio: CGFloat
    
    public init(duration: TimeInterval = 0.25, dampingRatio: CGFloat = 0.7) {
        self.duration = duration
        self.dampingRatio = dampingRatio
    }
    
    public func animator() -> UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: dampingRatio, animations: nil)
        return animator
    }
    
}

open class ControlPointAnimatorProvider: AnimatorProvider {
    
    public private(set) var duration: TimeInterval
    private var controlPoint1: CGPoint
    private var controlPoint2: CGPoint
    
    public init(duration: TimeInterval = 0.25, controlPoint1: CGPoint = CGPoint(x: 0.2, y: 0.9), controlPoint2: CGPoint = CGPoint(x: 0.8, y: 0.1)) {
        self.duration = duration
        self.controlPoint1 = controlPoint1
        self.controlPoint2 = controlPoint2
    }
    
    public func animator() -> UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: duration, controlPoint1: controlPoint1, controlPoint2: controlPoint2, animations: nil)
        return animator
    }
    
}

open class TimingParametersAnimatorProvider: AnimatorProvider {
    
    public private(set) var duration: TimeInterval
    private var timingParameters: UITimingCurveProvider
    
    public init(duration: TimeInterval, timingParameters: UITimingCurveProvider) {
        self.duration = duration
        self.timingParameters = timingParameters
    }
    
    public func animator() -> UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: timingParameters)
        return animator
    }
    
}
