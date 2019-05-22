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
    var trials : [TrialInfo]? = []
    var isGoTrial : [Bool] = []
    var trialImageFilenames : [String] = []
    
    
    
    /// Builds the isGoTrialList in this class based on whether its a practice block or not
    /// Practice block will be 10 trials and not will be 60
    /// - Parameter isPractice: set true if this is a practice block
    init(blockType: BlockType){
        self.blockType = blockType
        
        if (blockType == .practice){
            numberOfTrials = 10
        }else{
            numberOfTrials = 60
        }
        
        buildGoNoGo()
        buildMainBlockImageFilenames()
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
                isGoTrial.append(true)
                isGoTrial.append(false)
            }else if(i == 2){
                isGoTrial.append(true)
                isGoTrial.append(true)
                isGoTrial.append(false)
            }else{
                isGoTrial.append(true)
                isGoTrial.append(true)
                isGoTrial.append(true)
                isGoTrial.append(true)
                isGoTrial.append(false)
            }
        }
        
        var goCount = 0
        var noGoCount = 0
        for i in isGoTrial {
            if (i){
                goCount += 1
            }else{
                noGoCount += 1
            }
        }
                
    }
    
    func buildMainBlockImageFilenames(){
        var goSuffix = ""
        var noGoSuffix = ""
        var numNoGoM = 9
        var numNoGoF = 9
        var numGoM = 21
        var numGoF = 21
        
        
        switch blockType {
        case .practice:
            goSuffix = "N"
            noGoSuffix = "H"
            numNoGoM = 1
            numNoGoF = 2
            numGoM = 4
            numGoF = 3
        case .neutralangry:
            goSuffix = "N"
            noGoSuffix = "A"
        case .angryneutral:
            goSuffix = "A"
            noGoSuffix = "N"
        case .happyneutral:
            goSuffix = "H"
            noGoSuffix = "N"
        case .neutralhappy:
            goSuffix = "N"
            noGoSuffix = "H"
        }
        
        var goList : [String] = []
        var noGoList : [String] = []
        var imageNums : [Int] = [1,2,3,4,5,6]
        
        //  Set nogo male names
        imageNums.shuffle()
        for i in 1 ... numNoGoM {
            noGoList.append(noGoSuffix + "M" + String(imageNums[i%6]))
        }
        
        //  set nogo female names
        imageNums.shuffle()
        for i in 1 ... numNoGoF {
            noGoList.append(noGoSuffix + "F" + String(imageNums[i%6]))
        }
        
        //  Set go male names
        imageNums.shuffle()
        for i in 1 ... numGoM {
            goList.append(goSuffix + "M" + String(imageNums[i%6]))
        }
        
        //  set go female names
        imageNums.shuffle()
        for i in 1 ... numGoF {
            goList.append(goSuffix + "F" + String(imageNums[i%6]))
        }
        
        goList.shuffle()
        noGoList.shuffle()
        
        for i in 0 ..< numberOfTrials! {
            if ( isGoTrial[i] ){
                trialImageFilenames.append(goList.popLast()!)
            }else{
                trialImageFilenames.append(noGoList.popLast()!)
            }
        }
    }
    
}
