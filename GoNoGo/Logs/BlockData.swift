//
//  BlockData.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 28/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

struct BlockData {
    var trialDataArray : [TrialData] = Array(repeating: TrialData(), count: LogFileData.numberOfTrialsPerBlock)
}
