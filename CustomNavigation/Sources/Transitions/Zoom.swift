//
//  Zoom.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class Zoom: BaseTransition {
    
    override public func prepareForAnimation(with fromView: UIView?, and toView: UIView?) {
        guard !reverseTransition else { return }
        toView?.alpha = 0
        toView?.transform = CGAffineTransform.minScale
    }
    
    override public func performAnimation(with fromView: UIView?, and toView: UIView?) {
        guard reverseTransition else {
            toView?.reset()
            return }
        fromView?.transform = CGAffineTransform.minScale
        fromView?.alpha = 0
    }
    
    override public func completeTransition(with fromView: UIView?, and toView: UIView?) {
        super.completeTransition(with: fromView, and: toView)
        fromView?.alpha = 1
        toView?.alpha = 1
    }
    
}
