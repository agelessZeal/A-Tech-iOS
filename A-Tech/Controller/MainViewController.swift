//
//  MainViewController.swift
//  A-Tech
//
//  Created by WuSongBai on 2019/12/28.
//  Copyright © 2019 atecheng. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var alarmBtn: UIButton!
    @IBOutlet weak var trendsBtn: UIButton!
    @IBOutlet weak var historianBtn: UIButton!
    @IBOutlet weak var controlsBtn: UIButton!
    @IBOutlet weak var setpointsBtn: UIButton!
    @IBOutlet weak var configurationBtn: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let barColor = UIColor(red: 0.46, green: 0.07, blue: 0.00, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = barColor
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initMainView()
    }
    
    func initMainView() {
        
        let userName = UserDefaults.standard.string(forKey: "Name")
        userNameLabel.text = userName
        
        // Button UI...
        alarmBtn.layer.cornerRadius = 5
        alarmBtn.clipsToBounds = true
        
        trendsBtn.layer.cornerRadius = 5
        trendsBtn.clipsToBounds = true
        
        historianBtn.layer.cornerRadius = 5
        historianBtn.clipsToBounds = true
        
        controlsBtn.layer.cornerRadius = 5
        controlsBtn.clipsToBounds = true
        
        setpointsBtn.layer.cornerRadius = 5
        setpointsBtn.clipsToBounds = true
        
        configurationBtn.layer.cornerRadius = 5
        configurationBtn.clipsToBounds = true
    }
    
    @IBAction func onClickAlarmBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "MainToAlarm", sender: nil)
    }
    
    @IBAction func onClickTrendsBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "MainToTrends", sender: nil)
    }
    
    @IBAction func onClickHistorianBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "MainToHistorian", sender: nil)
    }
    
    @IBAction func onClickControlsBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "MainToControls", sender: nil)
    }
    
    @IBAction func onClickSetPointsBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "MainToSetpoints", sender: nil)
    }
    
    @IBAction func onClickConfigurationBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "MainToConfig", sender: nil)
    }
    
    @IBAction func onClickLogoutBtn(_ sender: UIButton) {
        
        let userId = UserDefaults.standard.object(forKey: "UserID")
        let url = URL(string: "http://3.24.138.90:8081/api/v2/user/logout/\(String(describing: userId))")
        guard let requestUrl = url else { fatalError()}
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if (json["success"] as? Int == 1) {
                    DispatchQueue.main.async {
                        let _ = self.navigationController?.popViewController(animated: true)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
