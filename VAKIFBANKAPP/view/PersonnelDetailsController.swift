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
    
    var selectedSicilNo : Int = 0
    var selectedDepartman = ""
    var selectedNameAndSurname = ""
    var selectedSicilNumber : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sicilNoTextField.addUnderLine()
        nameAndSurnameTextField.addUnderLine()
        departmentTextField.addUnderLine()
        sicilNoTextField.text = String(selectedSicilNo)
        departmentTextField.text = selectedDepartman
        nameAndSurnameTextField.text = selectedNameAndSurname
        sicilNoTextField.text = String(selectedSicilNo)
        
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEnvanterDetay"{
            
            let destinationForEmployeeProduct = segue.destination as! EmployeeProductController
            destinationForEmployeeProduct.employeeRequest = EmployeeCheck(id: selectedSicilNo)
        }
    }
    
    
    
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        
    }
    
    
}


