//
//  Fade.swift
//  CustomNavigation
//
//  Created by Sergey on 27.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class Fade: BaseTransition {
    
    public func prepareForAnimation(fromView: UIView?, toView: UIView?) {
        guard !reverseTransition else { return }
        toView?.alpha = 0
    }
    
    public func performAnimation(fromView: UIView?, toView: UIView?) {
        guard reverseTransition else {
            toView?.alpha = 1
            return }
        fromView?.alpha = 0
    }
    
    public func completeTransition(fromView: UIView?, toView: UIView?) {
        fromView?.alpha = 1
        toView?.alpha = 1
    }
    
}
