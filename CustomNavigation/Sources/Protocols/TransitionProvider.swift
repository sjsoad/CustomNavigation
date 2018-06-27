//
//  TransitionProvider.swift
//  SKCustomNavigation
//
//  Created by Sergey on 27.06.2018.
//

import UIKit

public enum TransitionDirection {
    case none
    case fromTop
    case fromLeft
    case fromRight
    case fromBottom
}

public protocol TransitionProvider {
    
    func prepareForAnimation(fromView: UIView?, toView: UIView?)
    func performAnimation(fromView: UIView?, toView: UIView?)
    func completeTransition(fromView: UIView?, toView: UIView?)
    
}
