//
//  DirectionalTransitioning.swift
//  Pods
//
//  Created by Sergey Kostyan on 28.06.2018.
//
//

import UIKit
import Foundation

public protocol DirectionalTransitioning {

    var transitionDirection: TransitionDirection { get }
    
}

public extension DirectionalTransitioning {
    
    func xPosition(for view: UIView?) -> CGFloat {
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
    
    func yPosition(for view: UIView?) -> CGFloat {
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
