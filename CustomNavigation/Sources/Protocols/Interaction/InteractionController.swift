//
//  InteractionController.swift
//  
//
//  Created by Sergey Kostyan on 29.06.2018.
//
//

import Foundation

public protocol InteractionController: UIViewControllerInteractiveTransitioning {

    var interactionInProgress: Bool { get set }
     // jist declear this property and CustomAnimatedTransitioning will work with it
    var interactionDelegate: InteractionControllerDelegate? { get set }
    
    func activate()
    func deactivate()
}
