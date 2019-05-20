//
//  Integer+Random.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 19/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import Foundation

extension UInt32 {
    
    func getRandomInt(low: UInt32, high: UInt32) -> UInt32? {
        return arc4random_uniform(high - low + 1) + low
    }
    
}
