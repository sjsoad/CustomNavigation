//
//  DefaultInteractiveNavigation.swift
//  SKCustomNavigation
//
//  Created by Sergey Kostyan on 16.08.2018.
//

import Foundation

public protocol DefaultInteractiveNavigation {
    
    var isDefaultInteractionEnabled: Bool { get }
    func set(defaultInteractionEnabled: Bool)
    
}
