//
//  InventoryCell.swift
//  VAKIFBANKAPP
//
//  Created by St900512 on 12.08.2022.
//

import UIKit

class InventoryCell: UITableViewCell {

    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameSurnameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
    }

    func setEmployee(employee: Employee?){
        guard let employee = employee else {
            return
        }

        nameSurnameLabel.text = employee.employeeName + " " + employee.employeeSurname
        idLabel.text = employee.guidId
        departmentLabel.text = employee.department
    }
}
