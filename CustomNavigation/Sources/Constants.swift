//
//  Constants.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 28.06.2018.
//

import Foundation

public typealias PresentationControllerProvider = (_ presented: UIViewController, _ presenting: UIViewController?,
    _ source: UIViewController) -> UIPresentationController?
public typealias SubviewsPair = (from: Subview, to: Subview)
public typealias Subview = (view: UIView, originalInfo: SubviewInfo)

public enum TransitionDirection {
    case fromTop
    case fromLeft
    case fromRight
    case fromBottom
}

public let defaultScale: CGFloat = 0.8
public let pushXDelta: CGFloat = 0.8
public let pushYDelta: CGFloat = 0.8

public struct SubviewInfo {
    var alpha: CGFloat
    var frame: CGRect
    var hidden: Bool
    
    public init(_ alpha: CGFloat, _ frame: CGRect, _ hidden: Bool) {
        self.alpha = alpha
        self.frame = frame
        self.hidden = hidden
    }
    
}
