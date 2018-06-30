//
//  InteractionControlling.swift
//  Pods
//
//  Created by Sergey Kostyan on 29.06.2018.
//
//

import UIKit
import Foundation

public protocol InteractionControlling: UIViewControllerInteractiveTransitioning {

    var interactionInProgress: Bool { get set }
    
}
