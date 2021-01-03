//
//  ViewController.swift
//  A-Tech
//
//  Created by WuSongBai on 2019/12/28.
//  Copyright © 2019 atecheng. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13, *)
        {
            let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
            
            let statusBar = UIView(frame: (keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = UIColor(red: 0.46, green: 0.07, blue: 0, alpha: 1.0)
            keyWindow?.addSubview(statusBar)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initLoginView()
    }
    
    func initLoginView() {
        
        // Button UI...
        loginBtn.layer.cornerRadius = loginBtn.bounds.height / 2
        loginBtn.clipsToBounds = true
        
        signupBtn.layer.cornerRadius = signupBtn.bounds.height / 2
        signupBtn.clipsToBounds = true
    }

    @IBAction func onClickLoginBtn(_ sender: UIButton) {
        
        let url = URL(string: "http://3.24.138.90:8081/api/v2/user/login")
        guard let requestUrl = url else { fatalError()}
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters : [String: Any] = [
            "email": emailTextField.text ?? "",
            "password": pwdTextField.text ?? ""
        ]
        let data = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = data;
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if (json["success"] as? Int == 1) {
                    let jsonData = json["data"] as? [String: Any]
                    UserDefaults.standard.set(jsonData?["token"] as? String, forKey: "Token")
                    UserDefaults.standard.set(jsonData?["channelId"] as? String, forKey: "ChannelID")
                    UserDefaults.standard.set(jsonData?["userId"] as? String, forKey: "UserID")
                    UserDefaults.standard.set(jsonData?["name"] as? String, forKey: "Name")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "LoginToMain", sender: nil)
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
    
    @IBAction func onClickSignupBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LoginToSignup", sender: nil)
    }
    
    @IBAction func onClickForgotPwd(_ sender: UIButton) {
        
        let url = URL(string: "http://3.24.138.90:8081/api/v2/user/forgotPassword")
        guard let requestUrl = url else { fatalError()}
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters : [String: Any] = [
            "email": emailTextField.text ?? ""
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
                        self.performSegue(withIdentifier: "LoginToForgotPwd", sender: nil)
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
}

