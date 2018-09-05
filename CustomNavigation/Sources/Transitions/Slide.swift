//
//  Slide.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class Slide: DirectionalTransition {
    
    override public func prepareForAnimation(with fromView: UIView?, and toView: UIView?) {
        let xPoint = xPosition(for: toView)
        let yPoint = yPosition(for: toView)
        guard reverseTransition else {
            toView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
            return }
        toView?.transform = CGAffineTransform(translationX: -xPoint, y: -yPoint)
    }
    
    override public func performAnimation(with fromView: UIView?, and toView: UIView?) {
        let xPoint = xPosition(for: fromView)
        let yPoint = yPosition(for: fromView)
        toView?.transform = .identity
        guard reverseTransition else {
            fromView?.transform = CGAffineTransform(translationX: -xPoint, y: -yPoint)
            return }
        fromView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
    }

}
