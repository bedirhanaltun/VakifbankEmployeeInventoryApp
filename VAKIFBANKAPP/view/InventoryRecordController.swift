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
    
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sicilNoTextField.addUnderLine()
        nameTextField.addUnderLine()
        surNameTextField.addUnderLine()
        departmentTextField.addUnderLine()
        inventoriesTextField.addUnderLine()

    }
    
    
    
    
    
    
    
    
    
    @IBAction func saveClickedButton(_ sender: Any) {
    }
    

}

