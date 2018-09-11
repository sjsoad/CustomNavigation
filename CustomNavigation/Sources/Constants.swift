//
//  Constants.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 28.06.2018.
//

import Foundation

public typealias PresentationControllerProvider = (_ presented: UIViewController, _ presenting: UIViewController?,
    _ source: UIViewController) -> UIPresentationController?

typealias SubviewsPair = (from: AnimatableSubview, to: AnimatableSubview)

public enum TransitionDirection {
    case fromTop
    case fromLeft
    case fromRight
    case fromBottom
}

public let defaultScale: CGFloat = 0.8
public let pushXDelta: CGFloat = 0.8
public let pushYDelta: CGFloat = 0.8
