//
//  Zoom.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class Zoom: BaseTransition {
    
    override public func prepareForAnimation(fromView: UIView?, toView: UIView?) {
        guard !reverseTransition else { return }
        toView?.alpha = 0
        toView?.transform = CGAffineTransform.minScale
    }
    
    override public func performAnimation(fromView: UIView?, toView: UIView?) {
        guard reverseTransition else {
            toView?.reset()
            return }
        fromView?.transform = CGAffineTransform.minScale
        fromView?.alpha = 0
    }
    
    override public func completeTransition(fromView: UIView?, toView: UIView?) {
        super.completeTransition(fromView: fromView, toView: toView)
        fromView?.alpha = 1
        toView?.alpha = 1
    }
    
}
