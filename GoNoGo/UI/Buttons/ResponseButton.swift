//
//  ResponseButtons.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 19/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import UIKit

class ResponseButton: UIButton {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        imageView?.contentMode = .scaleAspectFit
    }
    
    override var isHidden: Bool {
        didSet {
            if !isHidden {
                imageView?.contentMode = .scaleAspectFit
            }
        }
    }
    
 

}
