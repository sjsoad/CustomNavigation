//
//  UIImageView.swift
//  AERecord
//
//  Created by Sergey on 10.09.2018.
//

import UIKit

extension UIImageView {
    
    convenience init(with image: UIImage?, and frame: CGRect) {
        self.init(image: image)
        self.frame = frame
    }
    
}
