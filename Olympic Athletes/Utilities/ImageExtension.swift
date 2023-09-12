//
//  ImageExtension.swift
//  Olympic Athletes
//
//  Created by PADMANABHAN on 11/09/23.
//

import Foundation
import UIKit

extension UIImageView {
    
    func makeRounded() {
        
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
