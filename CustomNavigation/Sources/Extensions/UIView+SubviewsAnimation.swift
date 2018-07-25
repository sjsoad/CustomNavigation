//
//  UIView+SubviewsAnimation.swift
//  SKCustomNavigation
//
//  Created by Sergey on 12.07.2018.
//

import UIKit

public extension UIView {
    
    private static var subviewIdKey = "subviewId"
    private static var subviewsAnimationEnabledKey = "subviewsAnimationEnabled"
    
    @IBInspectable var subviewId: String? {
        get {
            return objc_getAssociatedObject(self, &UIView.subviewIdKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &UIView.subviewIdKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @IBInspectable var subviewsAnimationEnabled: Bool {
        get {
            return objc_getAssociatedObject(self, &UIView.subviewsAnimationEnabledKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &UIView.subviewsAnimationEnabledKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
