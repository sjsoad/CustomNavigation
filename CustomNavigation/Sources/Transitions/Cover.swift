//
//  Cover.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class Cover: DirectionalTransition {
    
    override public func prepareForAnimation(with fromView: UIView?, and toView: UIView?) {
        let xPoint = xPosition(for: toView)
        let yPoint = yPosition(for: toView)
        guard !reverseTransition else { return }
        toView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
    }
    
    override public func performAnimation(with fromView: UIView?, and toView: UIView?) {
        let xPoint = xPosition(for: fromView)
        let yPoint = yPosition(for: fromView)
        guard reverseTransition else {
            toView?.transform = .identity
            return }
        fromView?.transform = CGAffineTransform(translationX: xPoint, y: yPoint)
    }

}
