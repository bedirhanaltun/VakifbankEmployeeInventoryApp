//
//  ViewController.swift
//  VAKIFBANKAPP
//
//  Created by St900512 on 4.08.2022.
//

import UIKit
class ViewController: UIViewController{
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var sicilNoLabel: UILabel!
    @IBOutlet weak var sicilNoTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        sicilNoTextfield.addUnderLine()
        passwordTextfield.addUnderLine()
        sicilNoLabel.isHidden = true
        passwordLabel.isHidden = true
        sicilNoTextfield.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(ViewController.textFieldDidChangePassword(_:)), for: .editingChanged)
        
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
            let inventoryVC = self.storyboard?.instantiateViewController(withIdentifier: "registeredInventoryId") as! registeredInventoryController
            self.navigationController?.pushViewController(inventoryVC, animated: true)
        }
        
        
    }
    
    
    
    @IBAction func loginButtonClicked(_ sender: Any) {

        guard let sicilNo = sicilNoTextfield.text else {
            // Error  Label
            sicilNoLabel.isHidden = true
            return
        }
        
        guard let password = passwordTextfield.text  else {
            // Error  Label
            passwordLabel.isHidden = true
            return
        }
        
        if sicilNoTextfield.text == ""{
            sicilNoLabel.isHidden = false
            if passwordTextfield.text == ""{
                passwordLabel.isHidden = false
            }
            
        }
        else if sicilNoTextfield.text != sicilNo {
            if passwordTextfield.text == ""{
                passwordLabel.isHidden = false
            }
        }
        else if passwordTextfield.text != password {
            if sicilNoTextfield.text == ""{
                sicilNoLabel.isHidden = false
            }
        }
        else if sicilNoTextfield.text == sicilNo {
            if passwordTextfield.text == ""{
                passwordLabel.isHidden = false
            }
        }
        
        
        let requestModel = LoginCheckRequest(checkUsername: sicilNo, checkPassword: password)
        // Show Progress
        
        getLoginData(requestModel: requestModel) { response in
            guard let loginChecked = response else {
                // Hide progress
                return
            }
            
            
            if loginChecked.checkForLogin {
                // LOGIN SUCCESS
                UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                
                
                
                self.performSegue(withIdentifier: "registeredInventory", sender: nil)
                
            } else {
                
                self.showAlert(message: loginChecked.errorModel?.description)
                
                
            }
        }
        
        
    }
    
    
    
    
    private func getLoginData(requestModel: LoginCheckRequest, completion: @escaping (LoginCheckReponse?) -> Void)  {
        guard let url =  URL(string: "https://employeeinventory20220810152033.azurewebsites.net/api/Login/LoginCheck") else { return }
        
        var request = URLRequest(url: url)
        request.httpBody = try? JSONEncoder().encode(requestModel)
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = [
            "accept" : "text/plain",
            "Content-Type" : "application/json-patch+json"
        ]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(nil) }
                
                // Show Error (error.localized)
                self.showAlert(message: "Hata")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {  return }
            
            
            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                // Show Error no data
                self.showAlert(message: "No Data")
                return
            }
            
            do {
                let loginCheckResponse = try JSONDecoder().decode(LoginCheckReponse.self, from: data)
                DispatchQueue.main.async { completion(loginCheckResponse) }
                
            } catch let decodingError {
                DispatchQueue.main.async { completion(nil) }
                // Show error
                self.showAlert(message: "Hata")
            }
            
        }.resume()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        sicilNoLabel.isHidden =  true
    }
    @objc func textFieldDidChangePassword(_ textField: UITextField) {
        
        passwordLabel.isHidden =  true
    }
    
    @IBAction func sicilNoChanged(_ sender: Any) {
        sicilNoLabel.text = "Sicil no giriniz."
    }
    
    @IBAction func passwordChaged(_ sender: Any) {
        passwordLabel.text = "Şifre giriniz."
    }
    
    @IBAction func hidePasswordClicked(_ sender: Any) {
        passwordTextfield.isSecureTextEntry.toggle()
    }
    
    
    
    func showAlert(message : String?){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
}
extension UITextField {
    
    func addUnderLine () {
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0.0, y: self.bounds.height + 3, width: self.bounds.width, height: 1.5)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
}
