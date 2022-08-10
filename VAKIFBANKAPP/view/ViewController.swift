//
//  ViewController.swift
//  VAKIFBANKAPP
//
//  Created by St900512 on 4.08.2022.
//

import UIKit

class ViewController: UIViewController{
    

    let sicilNo = "St900512"
    let password = "123456"
    
    @IBOutlet weak var sicilNoTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        if sicilNoTextfield.text == sicilNo{
            if passwordTextfield.text == password {
                self.performSegue(withIdentifier: "registeredInventory", sender: nil)
            }
            else {
                showAlert(message: "Wrong password.")
            }
        }
        else if passwordTextfield.text == password {
            showAlert(message: "Wrong sicil no.")
        }
        else {
            showAlert(message: "Wrong sicil no and password.")
        }
    
    }
    
    
    @IBAction func hidePasswordClicked(_ sender: Any) {
        passwordTextfield.isSecureTextEntry.toggle()
    }
    
    func showAlert(message : String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
}

