//
//  PersonnelDetailsController.swift
//  VAKIFBANKAPP
//
//  Created by irem on 8.08.2022.
//

import UIKit

class PersonnelDetailsController: UIViewController {

   
    @IBOutlet weak var sicilNoTextField: UITextField!
    
    @IBOutlet weak var nameAndSurnameTextField: UITextField!
    
    @IBOutlet weak var departmentTextField: UITextField!
    
    var selectedEmployee: Employee?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sicilNoTextField.addUnderLine()
        nameAndSurnameTextField.addUnderLine()
        departmentTextField.addUnderLine()
        sicilNoTextField.text = String(selectedEmployee?.recordId ?? 0)
        departmentTextField.text = selectedEmployee?.department
        nameAndSurnameTextField.text = (selectedEmployee?.employeeName ?? "") + " " + (selectedEmployee?.employeeSurname ?? "")
        
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEnvanterDetay"{
            
            let destinationForEmployeeProduct = segue.destination as! EmployeeProductController
            destinationForEmployeeProduct.employeeRequest = EmployeeCheck(id: selectedEmployee?.recordId ?? 0)
        }
        
        if segue.identifier == "toUpdateInventory"{
            let destinationUpdateEmployee = segue.destination as! UpdateInventoryController
            destinationUpdateEmployee.selectedEmployee = selectedEmployee
        }
    }
    
    
    
    
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        
    }
    
    
}


