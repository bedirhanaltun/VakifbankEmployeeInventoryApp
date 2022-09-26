//
//  registeredInventoryController.swift
//  VAKIFBANKAPP
//
//  Created by irem on 8.08.2022.
//

import UIKit


class registeredInventoryController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    
    
    var employeeList: [Employee] = []
    var filteredList: [Employee] = []
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
    let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
    @IBOutlet weak var invertoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invertoryTableView.delegate = self
        invertoryTableView.dataSource = self
        searchBar.delegate = self
        self.hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(logOutButtonClicked))
        
        
        
        //To-Do: Get Product List Çağır. Dönen cevabı Cache ile tut.
        
        getInventoryData { productResponseForPersonel in
            guard let inventoryDataChecked = productResponseForPersonel else{
                return
            }
            
            Cache.shared.productListArray = inventoryDataChecked.productList ?? []
        }
        
        showProgress(message: "Veriler yükleniyor ...")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getEmployeeData { response in
            self.stopProgress()
            guard let employeDataChecked = response else{
                return
            }
            self.employeeList = employeDataChecked.employeeList
            self.filteredList = employeDataChecked.employeeList
            
            
            
            self.invertoryTableView.reloadData()
        }
        
    }
    
    
    @objc func logOutButtonClicked(){
        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        performSegue(withIdentifier: "toLoginScreen", sender: nil)
    }
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toEnvanterKayit", sender: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty{
            filteredList = employeeList
            invertoryTableView.reloadData()
            return
        }
        
        
        filteredList.removeAll()
        for employee in employeeList where employee.employeeName.lowercased().contains(searchText.lowercased()){
            filteredList.append(employee)
            
        }
        
        invertoryTableView.reloadData()
    }
    
    
    
    
    
    
    private func getInventoryData(completion: @escaping (InventoryResponse?) -> Void){
        guard let inventoryUrl = URL(string: "https://employeeinventory20220915181631.azurewebsites.net/api/Product/GetProductList") else{
            return
        }
        var inventoryRequest = URLRequest(url: inventoryUrl)
        inventoryRequest.allHTTPHeaderFields = ["accept": "text/plain"]
        inventoryRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: inventoryRequest) { inventoryData, inventoryResponse, inventoryError in
            if let inventoryError = inventoryError {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            guard let inventoryResponse = inventoryResponse as? HTTPURLResponse else {
                return
            }
            
            guard let inventoryData = inventoryData else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do{
                let inventoryCheckResponse = try JSONDecoder().decode(InventoryResponse.self, from: inventoryData)
                DispatchQueue.main.async {
                    completion(inventoryCheckResponse)
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
        }.resume()
    }
    
    private func getEmployeeData( completion: @escaping (EmployeeResponse?) -> Void){
        guard let employeeUrl = URL(string: "https://employeeinventory20220915181631.azurewebsites.net/api/Employee/GetEmployeeList") else{
            return
        }
        var employeeRequest = URLRequest(url: employeeUrl)
        employeeRequest.httpMethod = "GET"
        employeeRequest.allHTTPHeaderFields = ["accept" : "text/plain"]
        
        
        URLSession.shared.dataTask(with: employeeRequest) {
            employeeData, employeeResponse, employeeError in
            if let employeeError = employeeError {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard let employeeResponse = employeeResponse as? HTTPURLResponse else {
                return
            }
            print(employeeResponse)
            guard let employeeData = employeeData else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                
                return
            }
            
            do{
                let employeeCheckResponse = try JSONDecoder().decode(EmployeeResponse.self, from: employeeData)
                //self.filteredProducttArray = inventoryCheckResponse
                
                DispatchQueue.main.async {
                    completion(employeeCheckResponse)
                }
            }catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            
            
        }.resume()
    }
    
    //Delete APIS
    
    private func deleteEmployees(requestModelDeleteEmployees: DeleteEmployeeCheck, completion: @escaping (DeleteEmployee?) -> Void){
        
        guard let deleteEmployeeUrl = URL(string: "https://employeeinventory20220915181631.azurewebsites.net/api/Employee/DeleteEmployees") else{
            return
        }
        var deleteEmployeeRequest = URLRequest(url: deleteEmployeeUrl)
        deleteEmployeeRequest.httpMethod = "POST"
        deleteEmployeeRequest.httpBody = try? JSONEncoder().encode(requestModelDeleteEmployees)
        deleteEmployeeRequest.allHTTPHeaderFields = ["accept": "text/plain","Content-Type": "application/json-patch+json"]
        
        URLSession.shared.dataTask(with: deleteEmployeeRequest) { deleteEmployeeData, deleteEmployeeResponse, deleteEmployeeError in
            if let deleteEmployeeError = deleteEmployeeError {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            guard let deleteEmployeeResponse = deleteEmployeeResponse  as? HTTPURLResponse  else {
                return
            }
            
            guard let deleteEmployeeData = deleteEmployeeData else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do{
                let deleteEmployeeCheckResponse = try? JSONDecoder().decode(DeleteEmployee.self, from: deleteEmployeeData)
                DispatchQueue.main.async {
                    completion(deleteEmployeeCheckResponse)
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
        }.resume()
        
    }
    
    
    private func deleteEmployeeProduct(requestModelDeleteEmployeeProduct: DeleteEmployeeProductCheck, completion: @escaping (DeleteEmployeeProduct?) -> Void){
        
        guard let deleteEmployeeProductUrl = URL(string: "https://employeeinventory20220915181631.azurewebsites.net/api/EmployeeProduct/DeleteEmployeeProducts")
        else{
            return
        }
        
        var deleteEmployeeProductRequest = URLRequest(url: deleteEmployeeProductUrl)
        deleteEmployeeProductRequest.allHTTPHeaderFields = ["accept": "text/plain","Content-Type": "application/json-patch+json"]
        deleteEmployeeProductRequest.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: deleteEmployeeProductRequest) { deleteEmployeeProductData, deleteEmployeeProductResponse, deleteEmployeeProductError in
            if let deleteEmployeeProductError = deleteEmployeeProductError {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            guard let deleteEmployeeProductResponse = deleteEmployeeProductResponse as? HTTPURLResponse  else {
                return
            }
            
            guard let deleteEmployeeProductData = deleteEmployeeProductData else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do{
                let deleteEmployeeProductCheckResponse = try? JSONDecoder().decode(DeleteEmployeeProduct.self, from: deleteEmployeeProductData)
                DispatchQueue.main.async {
                    completion(deleteEmployeeProductCheckResponse)
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            
        }.resume()
    }
    
    private func deleteProduct(requestModelDeleteProduct: DeleteProductCheck, completion: @escaping (DeleteProduct?) -> Void){
        
        guard let deleteProductUrl = URL(string: "https://employeeinventory20220915181631.azurewebsites.net/api/Product/DeleteProducts") else{
            return
        }
        var deleteProductRequest = URLRequest(url: deleteProductUrl)
        deleteProductRequest.httpMethod = "POST"
        deleteProductRequest.allHTTPHeaderFields = ["accept": "text/plain","Content-Type": "application/json-patch+json"]
        
        URLSession.shared.dataTask(with: deleteProductRequest) { deleteProductData, deleteProductResponse, deleteProductError in
            if let deleteProductError = deleteProductError {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            guard let deleteProductResponse = deleteProductResponse as? HTTPURLResponse else {
                return
            }
            
            guard let deleteProductData = deleteProductData else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do{
                let deleteProductCheckResponse = try? JSONDecoder().decode(DeleteProduct.self, from: deleteProductData)
                DispatchQueue.main.async {
                    completion(deleteProductCheckResponse)
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
        }.resume()
    }
    
    //USER DEFAULTS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPersonelDetay"{
            let destinationVC = segue.destination as! PersonnelDetailsController
            destinationVC.selectedEmployee = sender as? Employee
            
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let getEmployee = filteredList[indexPath.row]
 
        self.performSegue(withIdentifier: "toPersonelDetay", sender: getEmployee)
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inventoryCell") as! InventoryCell
        let employee = filteredList[indexPath.row]
        cell.setEmployee(employee: employee)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            let alert = UIAlertController(title: "Personel Sil", message: "Silmek istediğinizden emin misiniz?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {[self] (action:UIAlertAction!) in
                let getEmployeeId = filteredList[indexPath.row]
                let chosenSicilNumber = getEmployeeId.recordId
                
                let deleteEmployeeRequestModel = DeleteEmployeeCheck(id: chosenSicilNumber)
                deleteEmployees(requestModelDeleteEmployees: deleteEmployeeRequestModel) { [self] deleteEmployeeResponse in
                    guard let deleteEmployeeDataChecked = deleteEmployeeResponse
                    else{
                        return
                    }
                    
                    if let errorModel = deleteEmployeeDataChecked.errorModel{
                        //Show Error
                        self.showAlert(alertText: "Hata", alertMessage: errorModel.errorModelDescription)
                        return
                    }
                    
                    filteredList.remove(at: indexPath.row)
                    invertoryTableView.beginUpdates()
                    invertoryTableView.deleteRows(at: [indexPath], with: .fade)
                    invertoryTableView.endUpdates()
                    invertoryTableView.reloadData()
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
        
    }
    
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
