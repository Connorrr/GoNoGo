//
//  UIImage+StimSelect.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 19/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func getRedStimulus() -> (UIImage?, UInt32?) {
        let int : UInt32 = 0
        var image : UIImage?
        
        let rand = int.getRandomInt(low: 1, high: 4)
        let randBoolPlaceHolder = false
        let isFruit = randBoolPlaceHolder.randomBool()
        if rand == 1 {
            if isFruit {
                image = #imageLiteral(resourceName: "rf1.jpg")
            }else{
                image = #imageLiteral(resourceName: "rv1.jpg")
            }
        }else if rand == 2 {
            if isFruit {
                image = #imageLiteral(resourceName: "rf2.jpg")
            }else{
                image = #imageLiteral(resourceName: "rv2.jpg")
            }
        }else if rand == 3 {
            if isFruit {
                image = #imageLiteral(resourceName: "rf3.jpg")
            }else{
                image = #imageLiteral(resourceName: "rv3.jpg")
            }
        }else if rand == 4 {
            if isFruit {
                image = #imageLiteral(resourceName: "rf4.jpg")
            }else{
                image = #imageLiteral(resourceName: "rv4.jpg")
            }
        }else{
            image = nil
            print("ERROR:UIIMAGE:getEvenStimulus: incorrect random value:  \(String(describing: rand))")
        }
        
        return (image, rand)
    }
    
    func getGreenStimulus() -> (UIImage?, UInt32?)  {
        let int : UInt32 = 0
        var image : UIImage?
        
        let rand = int.getRandomInt(low: 1, high: 4)
        let randBoolPlaceHolder = false
        let isFruit = randBoolPlaceHolder.randomBool()
        if rand == 1 {
            if isFruit {
                image = #imageLiteral(resourceName: "gf1.jpg")
            }else{
                image = #imageLiteral(resourceName: "gv1.jpg")
            }
        }else if rand == 2 {
            if isFruit {
                image = #imageLiteral(resourceName: "gf2.jpg")
            }else{
                image = #imageLiteral(resourceName: "gv2.jpg")
            }
        }else if rand == 3 {
            if isFruit {
                image = #imageLiteral(resourceName: "gf3.jpg")
            }else{
                image = #imageLiteral(resourceName: "gv3.jpg")
            }
        }else if rand == 4 {
            if isFruit {
                image = #imageLiteral(resourceName: "gf4.jpg")
            }else{
                image = #imageLiteral(resourceName: "gv4.jpg")
            }
        }else{
            image = nil
            print("ERROR:UIIMAGE:getOddStimulus: incorrect random value:  \(String(describing: rand))")
        }
        
        return (image, rand)
    }
    
    func getVegeStimulus() -> (UIImage?, UInt32?) {
        let int : UInt32 = 0
        var image : UIImage?
        
        let rand = int.getRandomInt(low: 1, high: 4)
        let randBoolPlaceHolder = false
        let isGreen = randBoolPlaceHolder.randomBool()
        if rand == 1 {
            if isGreen {
                image = #imageLiteral(resourceName: "gv1.jpg")
            }else{
                image = #imageLiteral(resourceName: "rv1.jpg")
            }
        }else if rand == 2 {
            if isGreen {
                image = #imageLiteral(resourceName: "gv2.jpg")
            }else{
                image = #imageLiteral(resourceName: "rv2.jpg")
            }
        }else if rand == 3 {
            if isGreen {
                image = #imageLiteral(resourceName: "gv3.jpg")
            }else{
                image = #imageLiteral(resourceName: "rv3.jpg")
            }
        }else if rand == 4 {
            if isGreen {
                image = #imageLiteral(resourceName: "gv4.jpg")
            }else{
                image = #imageLiteral(resourceName: "rv4.jpg")
            }
        }else{
            image = nil
            print("ERROR:UIIMAGE:getAboveStimulus: incorrect random value:  \(String(describing: rand))")
        }
        
        return (image, rand)
    }
    
    func getFruitStimulus() -> (UIImage?, UInt32?) {
        let int : UInt32 = 0
        var image : UIImage?
        
        let rand = int.getRandomInt(low: 1, high: 4)
        let randBoolPlaceHolder = false
        let isGreen = randBoolPlaceHolder.randomBool()
        if rand == 1 {
            if isGreen {
                image = #imageLiteral(resourceName: "gf1.jpg")
            }else{
                image = #imageLiteral(resourceName: "rf1.jpg")
            }
        }else if rand == 2 {
            if isGreen {
                image = #imageLiteral(resourceName: "gf2.jpg")
            }else{
                image = #imageLiteral(resourceName: "rf2.jpg")
            }
        }else if rand == 3 {
            if isGreen {
                image = #imageLiteral(resourceName: "gf3.jpg")
            }else{
                image = #imageLiteral(resourceName: "rf3.jpg")
            }
        }else if rand == 4 {
            if isGreen {
                image = #imageLiteral(resourceName: "gf4.jpg")
            }else{
                image = #imageLiteral(resourceName: "rf4.jpg")
            }
        }else{
            image = nil
            print("ERROR:UIIMAGE:getAboveStimulus: incorrect random value:  \(String(describing: rand))")
        }
        
        return (image,rand)
    }
    
}
