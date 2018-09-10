//
//  UIView.swift
//  SKCustomNavigation
//
//  Created by Sergey on 05.09.2018.
//

import UIKit

extension UIView {
    
    // MARK: - Utils -
    
    func reset() {
        alpha = 1
        transform = .identity
    }
    
    // MARK: - Rendering -
    
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        layer.render(in: currentContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func imageView() -> UIImageView {
        return UIImageView(with: snapshot(), and: bounds)
    }
    
    // MARK: - Subviews -
    
    var flattenSubviews: [UIView] {
        return [self] + subviews.flatMap({ $0.flattenSubviews })
    }
    
    var subview: Subview {
        return (view: self, originalInfo: info)
    }
    
    var info: SubviewInfo {
        return SubviewInfo(alpha, frame, isHidden)
    }
    
}
