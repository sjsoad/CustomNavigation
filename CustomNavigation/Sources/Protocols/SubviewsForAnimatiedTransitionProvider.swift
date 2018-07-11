//
//  SubviewsForAnimatiedTransitionProvider.swift
//  Pods
//
//  Created by Sergey on 11.07.2018.
//  
//

import Foundation

public protocol SubviewsForAnimatiedTransitionProvider: class {

    var viewsToAnimate: [UIView] { get }
    
}
