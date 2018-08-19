//
//  Zoom.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class Zoom: BaseTransition {
    
    public func prepareForAnimation(fromView: UIView?, toView: UIView?) {
        guard !reverseTransition else { return }
        toView?.alpha = 0
        toView?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
    
    public func performAnimation(fromView: UIView?, toView: UIView?) {
        guard reverseTransition else {
            toView?.transform = .identity
            toView?.alpha = 1
            return }
        fromView?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        fromView?.alpha = 0
    }
    
    public func completeTransition(fromView: UIView?, toView: UIView?) {
        fromView?.alpha = 1
        fromView?.transform = .identity
        toView?.alpha = 1
        toView?.transform = .identity
    }
    
}
