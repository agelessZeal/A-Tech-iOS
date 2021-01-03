//
//  SignupViewController.swift
//  A-Tech
//
//  Created by WuSongBai on 2019/12/28.
//  Copyright © 2019 atecheng. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var confirmpwdTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initSignupView()
    }
    
    func initSignupView() {
        
        //Button UI...
        submitBtn.layer.cornerRadius = submitBtn.bounds.height / 2
        submitBtn.clipsToBounds = true
        
        cancelBtn.layer.cornerRadius = cancelBtn.bounds.height / 2
        cancelBtn.clipsToBounds = true
    }
    
    @IBAction func onClickSubmitBtn(_ sender: UIButton) {
        
        let url = URL(string: "http://3.24.138.90:8081/api/v2/user/register")
        guard let requestUrl = url else { fatalError()}
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters : [String: Any] = [
            "confirmedPassword": confirmpwdTextField.text ?? "",
            "email": emailTextField.text ?? "",
            "name": nameTextField.text ?? "",
            "password": pwdTextField.text ?? "",
            "phone": phoneTextField.text ?? ""
        ]
        let data = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = data;
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(json["success"] ?? "")
                if (json["success"] as? Int == 1) {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "SignupToMain", sender: nil)
                    }
                } else {
                    let alertController = UIAlertController(title: "Error", message: json["message"] as? String, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(alertAction)
                    DispatchQueue.main.async {
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
        task.resume()
    }
    
    @IBAction func onClickCancelBtn(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
