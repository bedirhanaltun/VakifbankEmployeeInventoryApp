

import UIKit

class InventoryRecordController: UIViewController {
    
    @IBOutlet weak var sicilNoTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surNameTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    @IBOutlet weak var inventoriesTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sicilNoErrorLabel: UILabel!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var soyadErrorLabel: UILabel!
    @IBOutlet weak var adErrorLabel: UILabel!
    
    @IBOutlet weak var envanterErrorLabel: UILabel!
    @IBOutlet weak var departmanErrorLabel: UILabel!
    
    var getAddProduct : AddProduct?
    var getAddEmployeeProduct: AddEmployeeProduct?
    var employeeError: AddEmployeeError?
    
    var newProductId : Int = 0
    var newRecordId : Int = 0
    var newProductName = ""
    var newEmployeeName = ""
    var newEmployeeSurname = ""
    var newEmployeeDepartment = ""
    var newEmployeeEmail = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldSettings()
        
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        
        
        newRecordId = Int(sicilNoTextField.text ?? "") ?? 0
        newEmployeeName = nameTextField.text ?? ""
        newEmployeeSurname = surNameTextField.text ?? ""
        newEmployeeDepartment = departmentTextField.text ?? ""
        newEmployeeEmail = emailTextField.text ?? ""
        newProductId = Int(inventoriesTextField.text ?? "") ?? 0
        
        
        let requestModelAddEmployee = AddEmployeeCheck(newRecordId: newRecordId, newEmployeeName: newEmployeeName, newEmployeeSurname: newEmployeeSurname, newEmployeeDepartment: newEmployeeDepartment, newEmployeeEmail: newEmployeeEmail, newProductId: newProductId)
        
        addEmployee(requestModelAddEmployee: requestModelAddEmployee){ addEmployeeForAdminResponse in
            guard let addEmployeeDataChecked = addEmployeeForAdminResponse else{
                return
            }
            
            if let errorModel = addEmployeeDataChecked.errorModel {
                
                self.showAlert(alertText: "Hata", alertMessage: errorModel.errorModelDescription)
                return
            }
            
            self.navigationController?.popViewController(animated: true)
            
        }
        
        
        
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
                            if emailTextField.text == ""{
                                emailErrorLabel.isHidden = false
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    private func addProduct(requestModelAddProduct: AddProductCheck, completion: @escaping (AddProduct?) -> Void){
        guard let addProductUrl = URL(string: "https://employeeinventory20220915181631.azurewebsites.net/api/Product/AddProducts")
        else{
            return
        }
        
        var addProductRequest = URLRequest(url: addProductUrl)
        addProductRequest.allHTTPHeaderFields = ["accept": "text/plain","Content-Type": "application/json-patch+json"]
        addProductRequest.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: addProductRequest) { addProductData, addProductResponse, addProductError in
            if let addProductError = addProductError {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            guard let addProductResponse = addProductResponse as? HTTPURLResponse else {
                return
            }
            
            guard let addProductData = addProductData else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do{
                let addProductCheckResponse = try? JSONDecoder().decode(AddProduct.self, from: addProductData)
                DispatchQueue.main.async {
                    completion(addProductCheckResponse)
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            
        }.resume()
    }
    
    private func addEmployeeProduct(requestModelAddEmployeeProduct: AddEmployeeProductCheck, completion: @escaping (AddEmployeeProduct?) -> Void){
        guard let addEmployeeProductUrl = URL(string: "https://employeeinventory20220915181631.azurewebsites.net/api/EmployeeProduct/AddEmployeeProducts")
        else{
            return
        }
        var addEmployeeProductRequest = URLRequest(url: addEmployeeProductUrl)
        addEmployeeProductRequest.httpMethod = "POST"
        addEmployeeProductRequest.allHTTPHeaderFields = ["accept": "text/plain","Content-Type": "application/json-patch+json"]
        
        URLSession.shared.dataTask(with: addEmployeeProductRequest) { addEmployeeProductData, addEmployeeProductResponse, addEmployeeProductError in
            if let addEmployeeProductError = addEmployeeProductError {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            guard let addEmployeeProductResponse = addEmployeeProductResponse as? HTTPURLResponse  else {
                return
            }
            
            guard let addEmployeeProductData = addEmployeeProductData else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do{
                let addEmployeeProductCheckResponse = try? JSONDecoder().decode(AddEmployeeProduct.self, from: addEmployeeProductData)
                DispatchQueue.main.async {
                    completion(addEmployeeProductCheckResponse)
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            
        }.resume()
    }
    
    
    private func addEmployee(requestModelAddEmployee: AddEmployeeCheck, completion: @escaping (AddEmployee?) -> Void){
        
        guard let addEmployeeUrl = URL(string: "https://employeeinventory20220915181631.azurewebsites.net/api/Employee/AddEmployees")
        else{
            return
        }
        
        var addEmployeeRequest = URLRequest(url: addEmployeeUrl)
        addEmployeeRequest.httpMethod = "POST"
        addEmployeeRequest.httpBody = try? JSONEncoder().encode(requestModelAddEmployee)
        addEmployeeRequest.allHTTPHeaderFields = ["accept": "text/plain","Content-Type": "application/json-patch+json"]
        
        URLSession.shared.dataTask(with: addEmployeeRequest) { addEmployeeData, addEmployeeResponse, addEmployeError in
            if let addEmployeError = addEmployeError {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            guard let addEmployeeResponse = addEmployeeResponse as? HTTPURLResponse else {
                return
            }
            
            guard let addEmployeeData = addEmployeeData else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do{
                let addEmployeeCheckResponse = try? JSONDecoder().decode(AddEmployee.self, from: addEmployeeData)
                DispatchQueue.main.async {
                    completion(addEmployeeCheckResponse)
                }
            }catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            
        }.resume()
        
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
    
    
    private func textFieldSettings(){
        sicilNoTextField.addUnderLine()
        nameTextField.addUnderLine()
        surNameTextField.addUnderLine()
        departmentTextField.addUnderLine()
        inventoriesTextField.addUnderLine()
        emailTextField.addUnderLine()
        
        emailErrorLabel.isHidden = true
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
    
    
}

extension UIViewController {
    //Show a basic alert
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



