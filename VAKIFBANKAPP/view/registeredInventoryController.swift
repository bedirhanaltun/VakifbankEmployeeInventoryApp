//
//  registeredInventoryController.swift
//  VAKIFBANKAPP
//
//  Created by irem on 8.08.2022.
//

import UIKit

class registeredInventoryController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var nameArray = ["İrem Akgöz","Osman Yıldız","Mustafa Ozan Yaman","Bedirhan Altun","Selinay Özü"]
    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
    let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
    @IBOutlet weak var invertoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invertoryTableView.delegate = self
        invertoryTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            /*
            showError(message: "Silmek istediğinizden emin misiniz?", title: "Personel Sil")
            nameArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
             */
            let alert = UIAlertController(title: "Personel Sil", message: "Silmek istediğinizden emin misiniz?", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                    self.nameArray.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
            
            
        }
        
    }
    /*
    func showError(message : String, title:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    */
    
    
    
}

