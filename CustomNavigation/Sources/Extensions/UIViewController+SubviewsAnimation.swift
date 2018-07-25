//
//  UIViewController+SubviewsAnimation.swift
//  AERecord
//
//  Created by Sergey on 25.07.2018.
//

import UIKit

public extension UIViewController {
    
    private static var subviewsAnimationEnabledKey = "subviewsAnimationEnabled"
    
    @IBInspectable var subviewsAnimationEnabled: Bool {
        get {
            return objc_getAssociatedObject(self, &UIViewController.subviewsAnimationEnabledKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &UIViewController.subviewsAnimationEnabledKey, newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
