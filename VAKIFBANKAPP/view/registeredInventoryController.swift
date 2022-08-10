//
//  registeredInventoryController.swift
//  VAKIFBANKAPP
//
//  Created by irem on 8.08.2022.
//

import UIKit

class registeredInventoryController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var invertoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invertoryTableView.delegate = self
        invertoryTableView.dataSource = self

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

}
