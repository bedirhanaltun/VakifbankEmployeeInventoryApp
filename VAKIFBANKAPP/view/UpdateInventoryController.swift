//
//  UpdateInventoryController.swift
//  VAKIFBANKAPP
//
//  Created by irem on 8.08.2022.
//

import UIKit

class UpdateInventoryController: UIViewController {

    @IBOutlet weak var sicilNoTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var departmentTextField: UITextField!
    
    @IBOutlet weak var inventoryTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sicilNoTextField.addUnderLine()
        nameTextField.addUnderLine()
        surnameTextField.addUnderLine()
        departmentTextField.addUnderLine()
        inventoryTextField.addUnderLine()

    
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        
    }
    
    

}
