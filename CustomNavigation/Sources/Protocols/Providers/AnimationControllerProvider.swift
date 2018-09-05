//
//  AnimationControllerProvider.swift
//  SKUtils
//
//  Created by Sergey Kostyan on 07.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import Foundation

public protocol AnimationControllerProvider {
    
    var animatedTransitioning: CustomAnimatedTransitioning? { get set }
    
}
