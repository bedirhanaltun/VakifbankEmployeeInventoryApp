//
//  EmployeeProductController.swift
//  VAKIFBANKAPP
//
//  Created by Bedirhan Altun on 14.08.2022.
//

import UIKit

class EmployeeProductController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var employeeResponse : EmployeeProductList?
    var employeeRequest : EmployeeCheck?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeResponse?.employeeProductList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let getEmployee = employeeResponse?.employeeProductList?[indexPath.row]
        
        cell.textLabel?.text = getEmployee?.guidId
        return cell
    }
    @IBOutlet weak var employeeProductTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeProductTableView.delegate = self
        employeeProductTableView.dataSource = self
        
        
        guard let request = employeeRequest else{
            return
        }
        
        getEmployeeProduct(requestEmployeeProduct: request) { responseEmployee in
            guard let employeeChecked = responseEmployee else{
                return
            }
            
            self.employeeResponse = employeeChecked
            
            self.employeeProductTableView.reloadData()
            
            
        }
        
    }
    
    private func getEmployeeProduct(requestEmployeeProduct: EmployeeCheck,completion: @escaping (EmployeeProductList?) -> Void ){
        guard let productURL = URL(string: "https://employeeinventory20220810152033.azurewebsites.net/api/EmployeeProduct/GetEmployeeProductById")
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
        
}
        
        
