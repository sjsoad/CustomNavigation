//
//  PresentationControlling.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 29.06.2018.
//

import Foundation
import UIKit

public protocol PresentationControlling {
    
    var position: Position { get set }
    var percentageOfWidth: CGFloat { get set }
    var dimmingViewTapEventHandler: DimmingViewTapEventHandler? { get set }
    func configuredDimmingView() -> UIView?
    func addDimmingViewToView()
    func showDimmingView()
    func hideDimmingView()
}
