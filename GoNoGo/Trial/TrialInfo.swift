//
//  TrialInfo.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 15/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import UIKit

struct TrialInfo {
    var question : String?          //  Not really necessary at the moment
    var condition : TrialCondition?
    var correctResponse : TrialCondition?
    var stim : UIImage?             // For image stim
    var stimName : String?
    var stimLabel : String?         // For letter / number stimulus
    var letterNumberPair : LetterNumberStim?    //  The letter number pair
    var isEvenOdd : Bool?           //  Used to tell if it is an even/odd trial or vowel/consonant
    var isSwitchTrial : Bool?       //  Used to tell if this is a switch trial or not.
    var isEven : Bool?
    var isVowel : Bool?
}
