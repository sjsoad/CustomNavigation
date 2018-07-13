//
//  UIView+SubviewId.swift
//  SKCustomNavigation
//
//  Created by Sergey on 12.07.2018.
//

import UIKit

public extension UIView {
    
    private static var subviewIdKey = "subviewId"
    
    @IBInspectable var subviewId: String? {
        get {
            return objc_getAssociatedObject(self, &UIView.subviewIdKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &UIView.subviewIdKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
