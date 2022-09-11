//
//  EmployeeProductController.swift
//  VAKIFBANKAPP
//
//  Created by Bedirhan Altun on 14.08.2022.
//

import UIKit

class EmployeeProductController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var productList = [EmployeeProduct]()
    var employeeRequest : EmployeeCheck?
    
    var productResponseById: ProductLists?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let product = productList[indexPath.row]
        
        cell.textLabel?.text = product.name
        
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
            
            var products = employeeChecked.employeeProductList ?? []
            for index in products.indices {
                for product in Cache.shared.productListArray{
                    if products[index].productId == product.productId{
                        products[index].name = product.productName
                        break
                    }
                }
            }
            
            self.productList = products
            
            self.employeeProductTableView.reloadData()
        }
        
    }
    
    
    private func getProductByID(requestProductID: ProductCheck,completion: @escaping (ProductLists?) -> Void){
        
        guard let productIdUrl = URL(string: "https://employeeinventory20220810152033.azurewebsites.net/api/Product/GetProductById")
        else {
            return
        }
        
        var productRequest = URLRequest(url: productIdUrl)
        productRequest.httpMethod = "POST"
        productRequest.httpBody = try? JSONEncoder().encode(requestProductID) //--> Bu satırı sor.
        productRequest.allHTTPHeaderFields = ["accept" : "text/plain", "Content-Type" : "application/json-patch+json"]
        
        URLSession.shared.dataTask(with: productRequest) { productData, productResponse, productError in
            if let productError = productError {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
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
                let productCheckResponse = try JSONDecoder().decode(ProductLists.self, from: productData)
                DispatchQueue.main.async {
                    DispatchQueue.main.async {
                        completion(productCheckResponse)
                    }
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }


            
        }.resume()
    }
    
    
    
    
    public func getEmployeeProduct(requestEmployeeProduct: EmployeeCheck,completion: @escaping (EmployeeProductList?) -> Void ){
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
        
        
