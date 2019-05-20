//
//  LoginViewController.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 3/5/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idField: UITextField!
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        beginTrials()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginTrials(){
        LogFileMaker.removeUserData()
        let id = idField.text!
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async{
            if (id == ""){     //  id field empty
                //print("There was no text for me")
                let alert = UIAlertController(title: nil, message: "Please enter ID before you continue.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Return", style: UIAlertActionStyle.default, handler: nil))
                DispatchQueue.main.sync{
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    StaticVars.id = id
                    self.performSegue(withIdentifier: "loginToInstructions", sender: nil)
                }
            }
        }
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
