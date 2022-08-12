//
//  InventoryRecordController.swift
//  VAKIFBANKAPP
//
//  Created by irem on 8.08.2022.
//

import UIKit

class InventoryRecordController: UIViewController {
    
    @IBOutlet weak var sicilNoTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surNameTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    @IBOutlet weak var inventoriesTextField: UITextField!
    
    @IBOutlet weak var sicilNoErrorLabel: UILabel!
    
    @IBOutlet weak var soyadErrorLabel: UILabel!
    @IBOutlet weak var adErrorLabel: UILabel!
    
    @IBOutlet weak var envanterErrorLabel: UILabel!
    @IBOutlet weak var departmanErrorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sicilNoTextField.addUnderLine()
        nameTextField.addUnderLine()
        surNameTextField.addUnderLine()
        departmentTextField.addUnderLine()
        inventoriesTextField.addUnderLine()
        sicilNoErrorLabel.isHidden = true
        adErrorLabel.isHidden = true
        soyadErrorLabel.isHidden = true
        departmanErrorLabel.isHidden = true
        envanterErrorLabel.isHidden = true
        sicilNoTextField.addTarget(self, action: #selector(sicilNoFunction), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(adFunction), for: .editingChanged)
        surNameTextField.addTarget(self, action: #selector(soyadFunction), for: .editingChanged)
        departmentTextField.addTarget(self, action: #selector(departmanFunction), for: .editingChanged)
        inventoriesTextField.addTarget(self, action: #selector(envanterFunction), for: .editingChanged)
        

    }
    
    
    
    
    @IBAction func sicilNoChanged(_ sender: Any) {
        sicilNoErrorLabel.isHidden = false
    }
    
   
    @IBAction func adChanged(_ sender: Any) {
        adErrorLabel.isHidden = false
    }
    
    @IBAction func soyadChanged(_ sender: Any) {
        soyadErrorLabel.isHidden = false
    }
    
    @IBAction func departmanChanged(_ sender: Any) {
        departmanErrorLabel.isHidden = false
    }
    
    @IBAction func envanterChanged(_ sender: Any) {
        envanterErrorLabel.isHidden = false
        
    }
    @IBAction func saveClickedButton(_ sender: Any) {
        
        if sicilNoTextField.text == ""{
            sicilNoErrorLabel.isHidden = false
            if nameTextField.text == ""{
                adErrorLabel.isHidden = false
                if surNameTextField.text == ""{
                    soyadErrorLabel.isHidden = false
                    if departmentTextField.text == ""{
                        departmanErrorLabel.isHidden = false
                        if inventoriesTextField.text == ""{
                            envanterErrorLabel.isHidden = false
                        }
                    }
                }
            }
        }
        
        
    }
    
    @objc func sicilNoFunction(){
        sicilNoErrorLabel.isHidden = true
    }
    @objc func adFunction(){
        adErrorLabel.isHidden = true
    }
    @objc func soyadFunction(){
        soyadErrorLabel.isHidden = true
    }
    @objc func departmanFunction(){
       departmanErrorLabel.isHidden = true
    }
    @objc func envanterFunction(){
        envanterErrorLabel.isHidden = true
    }
        
}

