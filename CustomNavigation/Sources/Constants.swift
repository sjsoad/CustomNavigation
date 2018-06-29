//
//  Constants.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 28.06.2018.
//

import Foundation

public typealias PresentationControllerProvider = (_ presented: UIViewController, _ presenting: UIViewController?,
    _ source: UIViewController) -> UIPresentationController?

public typealias DimmingViewTapEventHandler = ((UITapGestureRecognizer) -> Void)

public enum TransitionDirection {
    case fromTop
    case fromLeft
    case fromRight
    case fromBottom
}

public enum xPosition {
    case left
    case center
    case right
    case custom(x: CGFloat)
}

public enum yPosition {
    case top
    case center
    case bottom
    case custom(y: CGFloat)
}

public struct Position {
    public var x: xPosition
    public var y: yPosition
    
    public init(x: xPosition, y: yPosition) {
        self.x = x
        self.y = y
    }
}
