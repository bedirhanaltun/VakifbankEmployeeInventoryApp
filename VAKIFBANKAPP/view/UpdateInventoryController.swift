//
//  UpdateInventoryController.swift
//  VAKIFBANKAPP
//
//  Created by irem on 8.08.2022.
//

import UIKit


class UpdateInventoryController: UIViewController {

    @IBOutlet weak var updateInventoryTextField: UITextField!
    
    @IBOutlet weak var updateDepartmentTextField: UITextField!
    @IBOutlet weak var updateSurnameTextField: UITextField!
    @IBOutlet weak var updateEmailTextField: UITextField!
    @IBOutlet weak var updateNameTextField: UITextField!
    @IBOutlet weak var updateSicilNoTextField: UITextField!
    
    var getUpdateEmployeeResponse : UpdateEmployee?
    var getUpdateProductResponse: UpdateProduct?
    var getUpdateEmployeeProductResponse: UpdateEmployeeProduct?
    var updateEmployeeRequest: EmployeeCheck?
 
    var selectedEmployee: Employee?
    var selectedUpdateEmployee: UpdateEmployee?
    private var productList = [EmployeeProduct]()
    
    var updatedProductId: Int = 0
    var updatedProductName: String = ""
    var updatedRecordId: Int = 0
    var updatedNewProductId: Int = 0
    
    var updatedEmployeeName: String = ""
    var updatedEmployeeSurname: String = ""
    var updatedEmployeeDepartment: String = ""
    var updatedEmployeeEmail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldSettings()
        
        guard let updateRequest = updateEmployeeRequest else{
            return
        }
        
        getUpdateEmployeeProduct(requestEmployeeProduct: updateRequest) { responseUpdateEmployee in
            guard let employeeChecked = responseUpdateEmployee else{
                return
            }
            
            var products = employeeChecked.employeeProductList ?? []
            for index in products.indices {
                for product in Cache.shared.productListArray{
                    if products[index].productId == product.productId{
                        products[index].name = product.productName
                        self.updateInventoryTextField.text = product.productName
                        break
                    }
                }
            }
            
            self.productList = products
    
        }
    
    }
    
    
    private func getUpdateEmployeeProduct(requestEmployeeProduct: EmployeeCheck,completion: @escaping (EmployeeProductList?) -> Void ){
        guard let productURL = URL(string: "https://employeeinventory20220915181631.azurewebsites.net/api/EmployeeProduct/GetEmployeeProductById")
        else{
            return
        }
        var employeeProductRequest = URLRequest(url: productURL)
        employeeProductRequest.httpMethod = "POST"
        employeeProductRequest.httpBody = try? JSONEncoder().encode(requestEmployeeProduct)
        
        employeeProductRequest.allHTTPHeaderFields = ["accept" : "text/plain", "Content-Type" : "application/json-patch+json"]
        
        URLSession.shared.dataTask(with: employeeProductRequest) { employeeProductData, employeeProductResponse, employeeProductError in
            if let employeeProductError = employeeProductError {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard let employeeProductResponse = employeeProductResponse as? HTTPURLResponse else{
                return
            }
            
            guard let employeeProductData = employeeProductData else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do{
                let employeeProductCheckResponse = try JSONDecoder().decode(EmployeeProductList.self, from: employeeProductData)
                DispatchQueue.main.async {
                    completion(employeeProductCheckResponse)
                }
                

        }
            catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()

}
    
    private func textFieldSettings(){
        updateSicilNoTextField.addUnderLine()
        updateNameTextField.addUnderLine()
        updateSurnameTextField.addUnderLine()
        updateDepartmentTextField.addUnderLine()
        updateInventoryTextField.addUnderLine()
        
//        sicilNoTextField.text = String(selectedEmployee?.recordId ?? 0)
//        departmentTextField.text = selectedEmployee?.department
//        nameTextField.text = selectedEmployee?.employeeName
//        surnameTextField.text = selectedEmployee?.employeeSurname
//        emailTextField.text = selectedEmployee?.employeeEmail
//        // ??
//        inventoryTextField.text = selectedEmployee?.guidId
        
        
    }
    
    private func updateEmployeeProduct(requestModelEmployeeProduct: UpdateEmployeeProductCheck, completion: @escaping (UpdateEmployeeProduct?) -> Void){
        guard let updateEmployeeProductUrl = URL(string: "https://employeeinventory20220915181631.azurewebsites.net/api/EmployeeProduct/UpdateEmployeeProducts")
        else{
            return
        }
        var updateEmployeeProductRequest = URLRequest(url: updateEmployeeProductUrl)
        updateEmployeeProductRequest.httpMethod = "POST"
        updateEmployeeProductRequest.httpBody = try? JSONEncoder().encode(requestModelEmployeeProduct)
        updateEmployeeProductRequest.allHTTPHeaderFields = ["accept": "text/plain","Content-Type": "application/json-patch+json"]
        
        URLSession.shared.dataTask(with: updateEmployeeProductRequest) { updateEmployeeProductData, updateEmployeeProductResponse, updateEmployeeProductError in
            if let updateEmployeeProductError = updateEmployeeProductError {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            guard let updateEmployeeProductResponse = updateEmployeeProductResponse as? HTTPURLResponse else {
                return
            }
            
            guard let updateEmployeeProductData = updateEmployeeProductData else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do{
                let updateEmployeeProductCheckResponse = try? JSONDecoder().decode(UpdateEmployeeProduct.self, from: updateEmployeeProductData)
                DispatchQueue.main.async {
                    completion(updateEmployeeProductCheckResponse)
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }


        }.resume()
    }
    
    private func updateProduct(requestModelProduct: UpdateProductCheck, completion: @escaping (UpdateProduct?) -> Void){
        
        guard let updateProductUrl = URL(string: "https://employeeinventory20220915181631.azurewebsites.net/api/Product/UpdateProducts") else{
            return
        }
        var updateProductRequest = URLRequest(url: updateProductUrl)
        updateProductRequest.allHTTPHeaderFields = ["accept": "text/plain" , "Content-Type": "application/json-patch+json"]
        updateProductRequest.httpBody = try? JSONEncoder().encode(requestModelProduct)
        updateProductRequest.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: updateProductRequest) { productData, productResponse, productError in
            if let productError = productError {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            guard let productResponse = productResponse as? HTTPURLResponse else {
                return
            }
            
            guard let productData = productData else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do{
                let productUpdateCheckResponse = try JSONDecoder().decode(UpdateProduct.self, from: productData)
                DispatchQueue.main.async {
                    completion(productUpdateCheckResponse)
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }


            
        }.resume()
    }
    
    
    private func updateEmployee(requestModelUpdateEmployee: UpdateEmployeeCheck,completion: @escaping (UpdateEmployee?) -> Void){

        guard let updateEmployeeUrl = URL(string: "https://employeeinventory20220915181631.azurewebsites.net/api/Employee/UpdateEmployees") else{
            return
        }

        var updateEmployeeRequest = URLRequest(url: updateEmployeeUrl)
        updateEmployeeRequest.httpMethod = "POST"
        updateEmployeeRequest.httpBody = try? JSONEncoder().encode(requestModelUpdateEmployee)
        updateEmployeeRequest.allHTTPHeaderFields = ["accept" : "text/plain", "Content-Type" : "application/json-patch+json"]

        URLSession.shared.dataTask(with: updateEmployeeRequest) { updateEmployeeData, updateEmployeeResponse, updateEmployeeError in

            if let updateEmployeeError = updateEmployeeError {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }

            guard let updateEmployeeResponse = updateEmployeeResponse as? HTTPURLResponse else {
                return
            }

            guard let updateEmployeeData = updateEmployeeData else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            do{
                let employeeUpdateCheckResponse = try? JSONDecoder().decode(UpdateEmployee.self, from: updateEmployeeData)
                DispatchQueue.main.async {
                    completion(employeeUpdateCheckResponse)
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }

        }.resume()

    }
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        
        updatedEmployeeName = updateNameTextField.text ?? ""
        updatedEmployeeSurname = updateSurnameTextField.text ?? ""
        updatedEmployeeDepartment = updateDepartmentTextField.text ?? ""
        updatedEmployeeEmail = updateEmailTextField.text ?? ""
        updatedRecordId = Int(updateSicilNoTextField.text ?? "") ?? 0
        
        
        let requestModelUpdate = UpdateEmployeeCheck(updatedRecordID: updatedRecordId, updatedEmployeeName: updatedEmployeeName, updatedEmployeeSurname: updatedEmployeeSurname, updatedEmployeeDepartment: updatedEmployeeDepartment, updatedEmployeeEmail: updatedEmployeeEmail, updatedProductID: 1, updatedNewProductID: 4)
        
        updateEmployee(requestModelUpdateEmployee: requestModelUpdate) { updateEmployeeResponse in
            guard let updateEmployeeDataChecked = updateEmployeeResponse else{
                return
            }
            
            print(updateEmployeeDataChecked)
            
            self.navigationController?.popViewController(animated: true)
        }
        
        
        let requestEmployeeProductUpdate = UpdateEmployeeProductCheck(updatedRecordId: updatedRecordId, updatedProductId: 4, updatedNewProductId: 3)
        
        updateEmployeeProduct(requestModelEmployeeProduct: requestEmployeeProductUpdate) { updateEmployeeProductResponse in
            guard let updateEmployeeProductDataChecked = updateEmployeeProductResponse else{
                return
            }
            
            print(updateEmployeeProductDataChecked)
        }
    }
    

}
