//
//  LoginViewController.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 3/5/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0       //  Used to shift the view when keyboard appears
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var groupNumberTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        if (idField.text!.count == 0){
            showAlert(title: "Error", message: "Please make sure that the ID Field is completed")
        }else if(!groupNumberTextField.text!.isInt){
            showAlert(title: "Error", message: "Please make sure the group is a number between 1 - 4")
        }else{
            beginTrials()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isEnabled = false
        groupNumberTextField.delegate = self
        groupNumberTextField.keyboardType = .numberPad
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(NSNotification.Name.UIKeyboardWillShow)
        NotificationCenter.default.removeObserver(NSNotification.Name.UIKeyboardWillHide)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight()
            view.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    
    func getKeyboardHeight() -> CGFloat {
        let shiftHeight = view.frame.height - (startButton.frame.origin.y + startButton.frame.height)
        return shiftHeight
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    //  Check that the input is an integer
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "1234").inverted
        let shouldUpdate = (string.rangeOfCharacter(from: invalidCharacters) == nil && (textField.text! + string).count < 2)
        if shouldUpdate {
            if (string.count != 0){
                startButton.isEnabled = true
            }
        }
        return shouldUpdate
    }
    
    func beginTrials(){
        LogFileMaker.removeUserData()
        StaticVars.id = idField.text!
        StaticVars.group = Int(groupNumberTextField.text!)!
        self.performSegue(withIdentifier: "loginToInstructions", sender: nil)
    }

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToInstructions" {
            if let instructionsViewController = segue.destination as? ViewController {
                instructionsViewController.fileName = self.idField.text!
            }
        }
    }*/

}


