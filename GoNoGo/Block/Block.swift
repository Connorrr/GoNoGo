//
//  Block.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 15/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import Foundation
import UIKit

class Block {
    
    let blockType : BlockType
    let numberOfTrials : Int?
    let startTrialCondition : TrialCondition
    let percentageSwitches : Int?
    var isEvenOdd : Bool?               // Tells whether the single trial block is even/odd or vowel/consonant
    var trials : [TrialInfo]? = []
    var isGoTrial : [Bool] = []
    
    
    
    
    /// Builds the isGoTrialList in this class based on whether its a practice block or not
    /// Practice block will be 10 trials and not will be 60
    /// - Parameter isPractice: set true if this is a practice block
    init(isPractice: Bool){
        isEvenOdd = false
        blockType = .single
        startTrialCondition = TrialCondition.consonant
        percentageSwitches = nil
        
        if (isPractice){
            numberOfTrials = 10
        }else{
            numberOfTrials = 60
        }
        
        buildGoNoGo()
    }
    
    /// Single condition initializer
    ///
    /// - Parameter trialCondition: This is the trial condition that will define wheather it is even/odd or vowel/consonants (note: the specific condition will be ignored)
    init(trialCondition: TrialCondition, isEvenOddBlock: Bool) {
        isEvenOdd = isEvenOddBlock
        numberOfTrials = 30
        blockType = .single
        startTrialCondition = trialCondition
        percentageSwitches = nil
        buildTrialList()
    }
    
    /// Initializer used for the updated practice trials and mixed block
    ///
    /// - Parameters:
    ///   - numberTrials: The numer of trials to be built in this block
    ///   - startingTrialCondition: This is the trial condition that will define wheather we start with even/odd or above/below (note: the specific condition will be ignored) however if this is a single blocktype then this value will describe the condition for the whole block
    ///   - isMixed: is this a mixed trial condition
    ///   - numerOfSwitches: if it is mixed how many switches will there be in the block
    init(numberTrials: Int, startingTrialCondition: TrialCondition, isMixed: Bool, percentageOfSwitches: Int?, isEvenOddStart:  Bool) {
        isEvenOdd = isEvenOddStart
        numberOfTrials = numberTrials
        if isMixed {
            blockType = .mixed
            startTrialCondition = startingTrialCondition
            if percentageOfSwitches == nil {
                print("numerOfSwitches must be set for mixed practice block")
                percentageSwitches = 0
                return
            }else{
                percentageSwitches = percentageOfSwitches!
            }
            
            if numberTrials == 120 {
                sortMixedBlock30()
            } else {
                sortMixedBlock()
            }
            
        } else {
            blockType = .single
            startTrialCondition = startingTrialCondition
            percentageSwitches = nil
        }
        buildTrialList()
    }
    
    private func buildGoNoGo(){
        var typeBlock : [Int] = []
        var loops : Int
        
        loops = numberOfTrials! / 10
        for _ in 1 ... loops {
            typeBlock.append(1)
            typeBlock.append(2)
            typeBlock.append(3)
        }
        
        typeBlock.shuffle()
        
        for i in typeBlock {
            if (i == 1){
                isGoTrial.append(false)
                isGoTrial.append(true)
            }else if(i == 2){
                isGoTrial.append(false)
                isGoTrial.append(false)
                isGoTrial.append(true)
            }else{
                isGoTrial.append(false)
                isGoTrial.append(false)
                isGoTrial.append(false)
                isGoTrial.append(false)
                isGoTrial.append(true)
            }
        }
        
        dump(isGoTrial)
        
    }
    
    private func buildTrialList() {
        
        var trial = TrialInfo()

        for i in 1 ... numberOfTrials! {
            
            trial = getTrial(trialNum: i)
            
            if blockType != .single {
                trial.isSwitchTrial = isGoTrial[i-1]
                if trial.isSwitchTrial! {
                    isEvenOdd = !isEvenOdd!
                }
                trial.isEvenOdd = isEvenOdd
            }else{
                trial.isSwitchTrial = false
                trial.isEvenOdd = isEvenOdd
            }
            
            if !trial.isEvenOdd! {           //  Need to reset the trial condition for the Vowel Consonant trials here because it is used in a different context during the getTrial method
                if trial.letterNumberPair!.isVowel! {
                    trial.condition = .vowel
                } else {
                    trial.condition = .consonant
                }
            }
            
            trials?.append(trial)
            
            //print(trial.stimLabel!)
        }

    }
    
    
    /// This function is used to sort a block of 120 trials with 30 switches (25%)
    private func sortMixedBlock30(){
        var switchArray = [2,4,4,3,5,3,1,2,5,2,1,4,2,6,2,3,5,6,5,4,6,4,6,5,6,6,6,5,4,3]    // The number of trials before another switch
        var sum = 0
        switchArray.shuffle()
        for i in switchArray {
            sum = i + sum
        }
        print("This is the sum check for the sort function.  This number should be 120:  \(sum)")
        
        for i in switchArray {
            isGoTrial.append(true)
            for _ in 1 ..< i {
                isGoTrial.append(false)
            }
        }
        
        print("This is the count for the switch array.  It should = 120:  \(isGoTrial.count)")
    }
    
    /// Fills the isTrialSwitch array with bools to use when building the mixed stim blocks
    private func sortMixedBlock() {
        
        var randomBool : Bool {
            let b = false
            return b.randomBool()
        }
        let multiplier = Float(percentageSwitches!)/100.0
        
        let switchCount : Int = Int((Float(numberOfTrials!) * multiplier).rounded(.down))
        let nonSwitchCount : Int = numberOfTrials! - switchCount
        var switchArray = Array(repeating: true, count: switchCount)
        var nonSwitchArray = Array(repeating: false, count: nonSwitchCount)
        
        var repeatSwitchCount : Int = 0
        var repeatNonSwitchCount : Int = 1
        
        isGoTrial.append(nonSwitchArray.removeFirst())
        //var isNoPull = true
        for _ in 1 ..< numberOfTrials! {
            //  THis part will be reincluded when we force the maximum repeats in a row factor
//            isNoPull = true
//            if repeatSwitchCount >= 3 {
//                isTrialSwitch.append(nonSwitchArray.removeFirst())
//                repeatNonSwitchCount = repeatNonSwitchCount + 1
//                repeatSwitchCount = 0
//                isNoPull = false
//            }else if repeatNonSwitchCount >= 3 {
//                isTrialSwitch.append(switchArray.removeFirst())
//                repeatSwitchCount = repeatSwitchCount + 1
//                repeatNonSwitchCount = 0
//                isNoPull = false
//            }else{
                if randomBool {     // Put in a switch trial if it's still available
                    if switchArray.count > 0 {
                        isGoTrial.append(switchArray.removeFirst())
                        repeatSwitchCount = repeatSwitchCount + 1
                        repeatNonSwitchCount = 0
                        //isNoPull = false
                    }else{
                        isGoTrial.append(nonSwitchArray.removeFirst())
                        repeatNonSwitchCount = repeatNonSwitchCount + 1
                        repeatSwitchCount = 0
                        //isNoPull = false
                    }
                }else{              // Put in a nonswitch trial if it's still available
                    if nonSwitchArray.count > 0 {
                        isGoTrial.append(nonSwitchArray.removeFirst())
                        repeatNonSwitchCount = repeatNonSwitchCount + 1
                        repeatSwitchCount = 0
                        //isNoPull = false
                    }else{
                        isGoTrial.append(switchArray.removeFirst())
                        repeatSwitchCount = repeatSwitchCount + 1
                        repeatNonSwitchCount = 0
                        //isNoPull = false
                    }
                }
//            }
//            if isNoPull {
//                if (switchArray.count - nonSwitchArray.count) >= 3 {
//                    isTrialSwitch.append(switchArray.removeFirst())
//                    repeatSwitchCount = repeatSwitchCount + 1
//                    repeatNonSwitchCount = 0
//                }else if (nonSwitchArray.count - switchArray.count) >= 3 {
//                    isTrialSwitch.append(nonSwitchArray.removeFirst())
//                    repeatNonSwitchCount = repeatNonSwitchCount + 1
//                    repeatSwitchCount = 0
//                }
//            }
        }
        //print(isTrialSwitch)
    }
    
    
    /// Returns the TrialInfo object that works for this trial.  This function makes usre that there aren't repeats.
    ///
    /// - Parameter trialNum: the current trial number
    /// - Returns: The LetterNumberStim object for this trial
    private func getTrial(trialNum: Int) -> TrialInfo {
        
        var trial = TrialInfo()
        var trialLetterNum : LetterNumberStim?
        var randomBool : Bool {
            let foo = false
            return foo.randomBool()
        }
        var randomIndex : Int {
            return Int.random( in: 0 ... 3 )
        }
        let isOdd = randomBool
        let isVowel = randomBool
        
        if isVowel {
            trial.condition = .vowel
        }else{
            trial.condition = .consonant
        }
        
        if isOdd {
            trial.condition = .odd
        }else{
            trial.condition = .even
        }
        
        if trialNum == 1 {
            trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, isOdd: isOdd, numberIndex: randomIndex)
        }else{
            if isOdd != trials![trialNum-2].isEven {        //  Does this and the last trial share number conditions
                if isVowel == trials![trialNum-2].isVowel { //  Does this and the last trial share letter conditions
                    if randomBool == true {                 //  Make sure the numbers are different
                        trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, isOdd: isOdd, numberIndex: randomIndex, excludingNumber: trials![trialNum-2].letterNumberPair!._number!)
                    }else{                                  // Make sure the letters are different
                        trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, excludingLetter: trials![trialNum-2].letterNumberPair!._letter!, isOdd: isOdd, numberIndex: randomIndex)
                    }
                }else{
                    trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, isOdd: isOdd, numberIndex: randomIndex)
                }
            }else{
                trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, isOdd: isOdd, numberIndex: randomIndex)
            }
        }

        trial.stimLabel = "\(trialLetterNum!._letter!)\(trialLetterNum!._number!)"
        trial.letterNumberPair = trialLetterNum
        
        return trial
    }
    
}
