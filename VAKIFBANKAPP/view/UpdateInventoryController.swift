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
    
    var getUpdateEmployeeResponse : UpdateEmployee?
    var getUpdateProductResponse: UpdateProduct?
    var getUpdateEmployeeProductResponse: UpdateEmployeeProduct?
    
    var updatedProductId: Int = 0
    var updatedProductName: String = ""
    var updatedRecordId: Int = 0
    var updatedNewProductId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sicilNoTextField.addUnderLine()
        nameTextField.addUnderLine()
        surnameTextField.addUnderLine()
        departmentTextField.addUnderLine()
        inventoryTextField.addUnderLine()
        
        updateEmployee { updateEmployeeForAdminResponse in
            guard let updateEmployeeDataChecked = updateEmployeeForAdminResponse else{
                return
            }
            
            self.getUpdateEmployeeResponse = updateEmployeeDataChecked
            
        }
        let requestModelProduct = UpdateProductCheck(updatedProductId: updatedProductId, updatedProductName: updatedProductName)
        
        updateProduct(requestModelProduct: requestModelProduct){ updateProductForAdminResponse in
            guard let updateProductDataChecked = updateProductForAdminResponse else{
                return
            }
            self.getUpdateProductResponse = updateProductDataChecked
        }
         
        let requestModelEmployeeProduct = UpdateEmployeeProductCheck(updatedRecordId: updatedRecordId, updatedProductId: updatedProductId, updatedNewProductId: updatedNewProductId)
        
        updateEmployeeProduct(requestModelEmployeeProduct: requestModelEmployeeProduct){ updateEmployeeProductForAdminResponse in
            guard let updateEmployeeProductDataChecked = updateEmployeeProductForAdminResponse else{
                return
            }
            self.getUpdateEmployeeProductResponse = updateEmployeeProductDataChecked
        }
    
    }
    
    private func updateEmployeeProduct(requestModelEmployeeProduct: UpdateEmployeeProductCheck, completion: @escaping (UpdateEmployeeProduct?) -> Void){
        guard let updateEmployeeProductUrl = URL(string: "https://employeeinventory20220810152033.azurewebsites.net/api/EmployeeProduct/UpdateEmployeeProducts")
        else{
            return
        }
        var updateEmployeeProductRequest = URLRequest(url: updateEmployeeProductUrl)
        updateEmployeeProductRequest.httpMethod = "POST"
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
        
        guard let updateProductUrl = URL(string: "https://employeeinventory20220810152033.azurewebsites.net/api/Product/UpdateProducts") else{
            return
        }
        var updateProductRequest = URLRequest(url: updateProductUrl)
        updateProductRequest.allHTTPHeaderFields = ["accept": "text/plain" , "Content-Type": "application/json-patch+json"]
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
    
    private func updateEmployee(completion: @escaping (UpdateEmployee?) -> Void){
        
        guard let updateEmployeeUrl = URL(string: "https://employeeinventory20220810152033.azurewebsites.net/api/Employee/UpdateEmployees") else{
            return
        }
        
        var updateEmployeeRequest = URLRequest(url: updateEmployeeUrl)
        updateEmployeeRequest.httpMethod = "POST"
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
            }catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }

        }.resume()
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        
    }
    
    

}
