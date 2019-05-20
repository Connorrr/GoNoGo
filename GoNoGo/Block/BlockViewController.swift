//
//  TrialViewController.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 15/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class BlockViewController: UIViewController {
    
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var stimImage: UIImageView!
    @IBOutlet weak var fixationCross: UILabel!
    @IBOutlet weak var boarderView: UIView!
    
    @IBOutlet weak var stimLabel: UILabel!
    @IBOutlet weak var leftButton: ResponseButton!
    @IBOutlet weak var fruitButton: ResponseButton!     //  This button is not used in the TS app
    @IBOutlet weak var redButton: ResponseButton!       //  This button is not used in the TS app
    @IBOutlet weak var rightButton: ResponseButton!
    
    var blockType : BlockType?
    var isEvenOdd : Bool?
    var block : Block?
    var blockProgress : Int?
    var blockData : [TrialData] = []
    
    var trialIndex : Int {
        return currentTrial-1
    }
    var currentTrial : Int = 1
    var trialData = TrialData()
    var trialTime : Double?
    var trialStartTime : Date?
    var audioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Set middle buttons to be invis in the containers
        redButton.alpha = 0.0
        fruitButton.alpha = 0.0
        
        print("The block type is:  ")
        dump(blockType)
        
        if StaticVars.id == "JasmineTest" {
            playEasterEgg()
        }
        
        block = Block(isPractice: false)
        
        let random = false
        if blockType != nil {
            if blockType == .mixed {
                if random.randomBool() {
                    block = Block(numberTrials: 120, startingTrialCondition: .vowel, isMixed: true, percentageOfSwitches: 25, isEvenOddStart:  false)
                } else {
                    block = Block(numberTrials: 120, startingTrialCondition: .even, isMixed: true, percentageOfSwitches: 25, isEvenOddStart:  true)
                }
            }else if blockType == .practice {
                if random.randomBool() {
                    block = Block(numberTrials: 30, startingTrialCondition: .vowel, isMixed: true, percentageOfSwitches: 50, isEvenOddStart:  false)
                } else {
                    block = Block(numberTrials: 30, startingTrialCondition: .even, isMixed: true, percentageOfSwitches: 50, isEvenOddStart:  true)
                }
            }else{
                if random.randomBool() {
                    block = Block(trialCondition: .vowel, isEvenOddBlock: isEvenOdd!)
                } else {
                    block = Block(trialCondition: .even, isEvenOddBlock: isEvenOdd!)
                }
            }
            
            executeBlock()
            
        }else{
            feedbackLabel.text = "ERROR: BlockViewController: Block Type missing"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        trialData.response = "left"
        if block!.trials![trialIndex].isEvenOdd! {
            checkCorr(response: .even)
        } else {
            checkCorr(response: .vowel)
        }
        forceProgress()
    }
    
    //  NOT USED
    @IBAction func fruitButtonPressed(_ sender: UIButton) {
        trialData.response = "fruit"
        checkCorr(response: .odd)
        forceProgress()
    }
    
    //  NOT USED
    @IBAction func redButtonPressed(_ sender: UIButton) {
        trialData.response = "red"
        checkCorr(response: .vowel)
        forceProgress()
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        trialData.response = "right"
        if block!.trials![trialIndex].isEvenOdd! {
            checkCorr(response: .odd)
        } else {
            checkCorr(response: .consonant)
        }
        forceProgress()
    }
    
    func setButtonLabels(isEvenOddTrial: Bool) {
        if isEvenOddTrial{
            leftButton.setImage(#imageLiteral(resourceName: "EvenButton.png"), for: .normal)
            rightButton.setImage(#imageLiteral(resourceName: "OddButton.png"), for: .normal)
        }else{
            leftButton.setImage(#imageLiteral(resourceName: "VowelButton.png"), for: .normal)
            rightButton.setImage(#imageLiteral(resourceName: "ConsonantButton.png"), for: .normal)
        }
    }
    
    //  Called after the response button is pressed
    func forceProgress () {
        responseTimer!.fire()
    }
    
    var trialTimer : Timer?
    var responseTimer : Timer?
    var blankTimer : Timer?
    var repeatTimer : Timer?
    
    func executeBlock() {

        //self.stimImage.image = block?.trials![trialIndex].stim!  //  No images in this version
        self.stimLabel.text = block?.trials![trialIndex].stimLabel
        if StaticVars.id == "JasmineTest" {
            self.stimImage.image = #imageLiteral(resourceName: "jasmine.jpg")
        }
        
        setButtonLabels(isEvenOddTrial: block!.trials![trialIndex].isEvenOdd!)
        
        setUpTrialData()
        
        //  Display Fixation for 1400 ms
        displayFixation()
    
        //  Show trial for 5000ms or first response
        trialTimer = Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false, block: { (trialTimer) in self.displayTrial() })
    
        //  25ms blank (called in displayTrial)
        
    }
    
    func displayFixation() {
        self.fixationCross.isHidden = false
        self.stimImage.isHidden = true
        self.stimLabel.isHidden = true
        self.boarderView.isHidden = true
        self.setButtonVisibility(isHidden: true)
    }
    
    func displayTrial() {
        self.setBoarder(isSwitch: block!.trials![trialIndex].isSwitchTrial!)
        self.fixationCross.isHidden = true
        //self.stimImage.isHidden = false
        self.stimLabel.isHidden = false
        self.setButtonVisibility(isHidden: false)
        self.responseTimer = Timer.scheduledTimer(withTimeInterval: 50000, repeats: false, block: { (responseTimer) in self.displayBlank() }) //Set to 50000 so it is essentially waiting for a response only
        self.trialStartTime = Date()
    }
    
    // THERE IS NO FEEDBACK IN THE TS APP SO THIS IS SKIPPED
    func displayResponse () {
        self.fixationCross.isHidden = true
        self.stimImage.isHidden = true
        self.stimLabel.isHidden = true
        self.boarderView.isHidden = true
        self.setButtonVisibility(isHidden: true)
        if self.trialData.corr != 1 {
            self.feedbackLabel.isHidden = false
        }
        self.blankTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (blankTimer) in self.displayBlank() })
    }
    
    func displayBlank() {
        getResponseTime()
        self.feedbackLabel.isHidden = true
        self.fixationCross.textColor = .black
        self.fixationCross.text = "+"
        self.fixationCross.isHidden = true
        self.stimImage.isHidden = true
        self.stimLabel.isHidden = true
        self.boarderView.isHidden = true
        let defaults = UserDefaults.standard
        let startTime = defaults.object(forKey: "startTime") as! Date
        if block!.trials![trialIndex].isEvenOdd!{
            trialData.trialCondition = "EvenOdd"
        }else{
            trialData.trialCondition = "VowelCons"
        }
        trialData.time = Date(timeIntervalSinceNow: 0.25).timeIntervalSince(startTime).description
        blockData.append(trialData)
        if (currentTrial < block!.trials!.count) {
            self.currentTrial = self.currentTrial + 1
            repeatTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: {(repeatTimer) in self.executeBlock()})
        }else{      //MARK:  This is the end of the trials
            saveBlockData()
            
            performSegue(withIdentifier: "returnToInstructions", sender: nil)
        }
    }
    
    func saveBlockData () {

        print("put in array")
        let currentLogData = blockData.map{$0.propertyListRepresentation}      //  Return the property list compliant version of the struct
        print("appending data")
        let fullLogs = getAppendedLogData(currentLogData: currentLogData)
        if fullLogs == nil { UserDefaults.standard.set(currentLogData, forKey: "BlockData") } else {
            UserDefaults.standard.set(fullLogs, forKey: "BlockData")
        }
        print("put in defaults")
    }
    
    func getAppendedLogData (currentLogData: [[String : Any]]) -> [[String : Any]]? {
        guard var propertyListLogs = UserDefaults.standard.object(forKey: "BlockData") as? [[String:Any]] else {
            print("'BlockData' not found in UserDefaults")
            return nil
        }
        
        for data in currentLogData {
            propertyListLogs.append(data)
        }
        
        return propertyListLogs
    }
    
    func setButtonVisibility(isHidden: Bool) {
        self.leftButton.isHidden = isHidden
        self.fruitButton.isHidden = isHidden
        self.redButton.isHidden = isHidden
        self.rightButton.isHidden = isHidden
    }
    
    func getResponseTime() {
        let endTime = Date()
        let rT = endTime.timeIntervalSince(trialStartTime!)
        trialData.rt = rT
    }
    
    func checkCorr(response: TrialCondition) {
        if response == block!.trials![trialIndex].condition! {
            trialData.corr = 1
        }else{
            trialData.corr = 0
        }
    }
    
    /// Sets the boarder visibility around stim
    func setBoarder(isSwitch: Bool) {
        if isSwitch {
            self.boarderView.isHidden = false
            trialData.isSwitchTrial = 1
        } else {
            self.boarderView.isHidden = true
            trialData.isSwitchTrial = 0
        }
    }
    
    func setUpTrialData() {
        trialData = TrialData()
        trialData.trialNum = currentTrial
        trialData.blockNumber = blockProgress!
        
        switch blockType! {
        case .practice:
            trialData.blockType = "Practice"
        case .mixed:
            trialData.blockType = "Mixed"
        case .single:
            trialData.blockType = "Single"
        }
        
        trialData.stim = block!.trials![trialIndex].stimLabel!
        switch block!.trials![trialIndex].condition! {
        case .vowel:
            trialData.trialCondition = "vowel"
        case .consonant:
            trialData.trialCondition = "consonant"
        case .even:
            trialData.trialCondition = "even"
        case .odd:
            trialData.trialCondition = "odd"
        }
    }
    
    func playEasterEgg () {
        guard let url = Bundle.main.url(forResource: "AWholeNewWorld", withExtension: "mp3") else {
            print("Couldn't find the file :(")
            return
        }
        
        do {
            print("Found It :)")
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            audioPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "returnToInstructions" {
            print("preparing for segue")
            if let viewController = segue.destination as? ViewController {
                if blockProgress! == 0 {
                    print("You are at the end of the practices")
                    viewController.instructionsState = .practiceEnd
                } else if blockProgress! + 1 < viewController.experimentStructure.count {
                    viewController.instructionsState = .breakText
                }else{
                    viewController.instructionsState = .goodbyeText
                }
                
                viewController.blockProgress = blockProgress! + 1
            }
        }
    }
}
