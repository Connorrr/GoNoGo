//
//  GenericFunctions.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 19/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import Foundation

extension Bool {
    
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
    
}


