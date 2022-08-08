//
//  ViewController.swift
//  VAKIFBANKAPP
//
//  Created by St900512 on 4.08.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var envanterTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        envanterTableView?.delegate = self
        envanterTableView?.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    @IBAction func addButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toEnvanterKayit", sender: nil)
    }
    
}

