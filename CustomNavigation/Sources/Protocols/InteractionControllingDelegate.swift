//
//  InteractionControllingDelegate.swift
//  AERecord
//
//  Created by Sergey on 17.08.2018.
//

import Foundation

public protocol InteractionControllingDelegate: class {
    
    func interactionDidBegan()
    func interactionDidUpdate(with progress: CGFloat)
    func interactionDidCanceled()
    func interactionDidEnded()
    
}
