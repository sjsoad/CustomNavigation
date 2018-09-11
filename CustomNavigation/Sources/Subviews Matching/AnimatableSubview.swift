//
//  AnimatableSubview.swift
//  SKCustomNavigation
//
//  Created by Sergey on 10.09.2018.
//

import UIKit

class AnimatableSubview {
    
    var view: UIView
    var alpha: CGFloat
    var convertedFrame: CGRect
    var snapshot: UIImageView
    
    init(with view: UIView, and container: UIView) {
        self.view = view
        self.alpha = view.alpha
        self.convertedFrame = container.convert(view.frame, from: view.superview)
        self.snapshot = view.imageView()
    }
    
    func hideOriginal() {
        view.alpha = 0
    }
    
    func restore() {
        snapshot.removeFromSuperview()
        view.alpha = alpha
    }
    
}
