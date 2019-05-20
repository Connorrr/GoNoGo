//
//  LetterNumberStim.swift
//  TaskSwitching
//
//  Created by Connor Reid on 11/12/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

struct LetterNumberStim {
    var _letter : String?
    var _number : Int?
    var isEven : Bool?
    var isVowel : Bool?
    
    let vowelLetters = ["A", "E", "I", "U"]
    let consonantLetters = ["M", "K", "G", "R"]
    let oddNumbers = [3, 5, 7, 9]
    let evenNumbers = [2, 4, 6, 8]
    
    init(isVowel: Bool, letterIndex: Int, isOdd: Bool, numberIndex: Int) {
        if isVowel {
            _letter = getVowel(index: letterIndex, excluding: nil)
        }else{
            _letter = getConsonant(index: letterIndex, excluding: nil)
        }
        
        if isOdd {
            _number = getOdd(index: numberIndex, excluding: nil)
        }else{
            _number = getEven(index: numberIndex, excluding: nil)
        }
        self.isVowel = isVowel
        self.isEven = !isOdd
    }
    
    init(isVowel: Bool, letterIndex: Int, excludingLetter: String, isOdd: Bool, numberIndex: Int) {
        if isVowel {
            let excIndex = vowelLetters.firstIndex(of: excludingLetter)
            if excIndex == nil {
                print("ERROR:  The specified excluding letter \(excludingLetter) was not in the vowel array")
                return
            }
            _letter = getVowel(index: letterIndex, excluding: excIndex)
        }else{
            let excIndex = consonantLetters.firstIndex(of: excludingLetter)
            if excIndex == nil {
                print("ERROR:  The specified excluding letter \(excludingLetter) was not in the consonant array")
                return
            }
            _letter = getConsonant(index: letterIndex, excluding: excIndex)
        }
        
        if isOdd {
            _number = getOdd(index: numberIndex, excluding: nil)
        }else{
            _number = getEven(index: numberIndex, excluding: nil)
        }
        self.isVowel = isVowel
        self.isEven = !isOdd
    }
    
    init(isVowel: Bool, letterIndex: Int, isOdd: Bool, numberIndex: Int, excludingNumber: Int) {
        if isVowel {
            _letter = getVowel(index: letterIndex, excluding: nil)
        }else{
            _letter = getConsonant(index: letterIndex, excluding: nil)
        }
        
        if isOdd {
            let excIndex = oddNumbers.firstIndex(of: excludingNumber)
            if excIndex == nil {
                print("ERROR:  The specified excluding number \(excludingNumber) was not in the odd array")
                return
            }
            _number = getOdd(index: numberIndex, excluding: excIndex)
        }else{
            let excIndex = evenNumbers.firstIndex(of: excludingNumber)
            if excIndex == nil {
                print("ERROR:  The specified excluding number \(excludingNumber) was not in the even array")
                return
            }
            _number = getEven(index: numberIndex, excluding: nil)
        }
        self.isVowel = isVowel
        self.isEven = !isOdd
    }
}

extension LetterNumberStim {
    
    
    /// Returns one of the selected vowels indext by: ["A", "E", "I", "U"]
    ///
    /// - Parameter index: the index for the vowel array (0 - 3)
    /// - Returns: the vowel
    func getVowel(index: Int, excluding: Int?) -> String {
        return vowelLetters[index]
    }
    
    
    /// Returns one of the preselected consonants by the index: ["M", "K", "G", "R"]
    ///
    /// - Parameter index: the index for consonant array (0 - 3)
    /// - Returns: the consonant
    func getConsonant(index: Int, excluding: Int?) -> String {
        return consonantLetters[index]
    }
    
    /// Returns an Odd number from the preselected odd number array by the index: [3, 5, 7, 9]
    ///
    /// - Parameter index: the index for odd number array (0 - 3)
    /// - Returns: the odd number
    func getOdd(index: Int, excluding: Int?) -> Int {
        return oddNumbers[index]
    }
    
    
    /// Returns the Even number from the preselected even numbers by the index: [2, 4, 6, 8]
    ///
    /// - Parameter index: the index for the even number array (0 - 3)
    /// - Returns: the even number
    func getEven(index: Int, excluding: Int?) -> Int {
        return evenNumbers[index]
    }
    
}
