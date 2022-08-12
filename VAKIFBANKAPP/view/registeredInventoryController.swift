//
//  registeredInventoryController.swift
//  VAKIFBANKAPP
//
//  Created by irem on 8.08.2022.
//

import UIKit

class registeredInventoryController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var inventoryResponse : EmployeeResponse?
    var chosensicilNo : Int = 0
    var chosenAd = ""
    var chosenSoyad = ""
    var chosenDepartman = ""
    
    //var nameArray = ["İrem Akgöz","Osman Yıldız","Mustafa Ozan Yaman","Bedirhan Altun","Selinay Özü"]
    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
    let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
    @IBOutlet weak var invertoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invertoryTableView.delegate = self
        invertoryTableView.dataSource = self
 
        
        getInventoryData { response in
            guard let inventoryDataChecked = response else{
                return
            }
            self.inventoryResponse = inventoryDataChecked
            self.invertoryTableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    private func getInventoryData( completion: @escaping (EmployeeResponse?) -> Void){
        guard let inventoryURL = URL(string: "https://employeeinventory20220810152033.azurewebsites.net/api/Employee/GetEmployeeList") else{
            return
        }
        var inventoryRequest = URLRequest(url: inventoryURL)
        inventoryRequest.httpMethod = "GET"
        inventoryRequest.allHTTPHeaderFields = ["accept" : "text/plain"]
        
        
        URLSession.shared.dataTask(with: inventoryRequest) {
            inventoryData, inventoryResponse, inventoryError in
            if let inventoryError = inventoryError {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard let inventoryResponse = inventoryResponse as? HTTPURLResponse else {
                return
            }
            print(inventoryResponse)
            guard let inventoryData = inventoryData else {
                DispatchQueue.main.async {
                    completion(nil)
                }

                return
            }
            
            do{
                let inventoryCheckResponse = try JSONDecoder().decode(EmployeeResponse.self, from: inventoryData)
                //self.filteredProducttArray = inventoryCheckResponse
                
                DispatchQueue.main.async {
                    completion(inventoryCheckResponse)
                }
            }catch{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            


        }.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPersonelDetay"{
            let destinationVC = segue.destination as! PersonnelDetailsController
            destinationVC.selectedSicilNo = chosensicilNo
            destinationVC.selectedDepartman = chosenDepartman
            destinationVC.selectedNameAndSurname = chosenAd + " " + chosenSoyad
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let getEmployee = inventoryResponse?.employeeList[indexPath.row]
        chosenAd = getEmployee?.employeeName ?? ""
        chosenSoyad = getEmployee?.employeeSurname ?? ""
        chosenDepartman = getEmployee?.department ?? ""
        chosensicilNo = getEmployee?.recordId ?? 0
        self.performSegue(withIdentifier: "toPersonelDetay", sender: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inventoryCell") as! InventoryCell
        let employee = inventoryResponse?.employeeList[indexPath.row]
        cell.setEmployee(employee: employee)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryResponse?.employeeList.count ?? 6
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
   
            let alert = UIAlertController(title: "Personel Sil", message: "Silmek istediğinizden emin misiniz?", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                    self.inventoryResponse?.employeeList.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
            
            
        }
        
    }
}

