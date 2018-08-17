//
//  DirectionalTransition.swift
//  AERecord
//
//  Created by Sergey on 17.08.2018.
//

import UIKit
import SKAnimator

open class DirectionalTransition: BaseTransition {

    public private(set) var transitionDirection: TransitionDirection
    
    public init(transitionDirection: TransitionDirection = .fromRight, animatorProvider: AnimatorProvider = DefaultAnimatorProvider()) {
        self.transitionDirection = transitionDirection
        super.init(animatorProvider: animatorProvider)
    }

    public func xPosition(for view: UIView?) -> CGFloat {
        guard let view = view else { return 0 }
        switch transitionDirection {
        case .fromRight:
            return view.frame.size.width + view.frame.origin.x
        case .fromLeft:
            return -(view.frame.size.width + view.frame.origin.x)
        default:
            return 0
        }
    }
    
    public func yPosition(for view: UIView?) -> CGFloat {
        guard let view = view else { return 0 }
        switch transitionDirection {
        case .fromTop:
            return -(view.frame.size.height + view.frame.origin.y)
        case .fromBottom:
            return view.frame.size.height + view.frame.origin.y
        default:
            return 0
        }
    }
    
}
