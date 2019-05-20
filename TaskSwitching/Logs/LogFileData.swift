//
//  LogFileData.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 28/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import Foundation

public struct LogFileData {
    static let numberOfBlocks = 22
    static let numberOfTrialsPerBlock = 17
    static var logData = Array(repeating: BlockData(), count: numberOfBlocks)
}
