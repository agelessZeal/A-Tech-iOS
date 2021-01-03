//
//  ConfigurationViewController.swift
//  A-Tech
//
//  Created by WuSongBai on 2019/12/28.
//  Copyright © 2019 atecheng. All rights reserved.
//

import UIKit
import iOSDropDown

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var deviceDropDown: DropDown!
    @IBOutlet weak var objectDropDown: UITextField!
    @IBOutlet weak var prop1DropDown: DropDown!
    @IBOutlet weak var val1TextField: UITextField!
    @IBOutlet weak var orDropDown: DropDown!
    @IBOutlet weak var prop2DropDown: DropDown!
    @IBOutlet weak var val2TextField: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
    }
    
    func initUI() {
        
        // Button UI...
        updateBtn.layer.cornerRadius = updateBtn.bounds.height / 2
        updateBtn.clipsToBounds = true
    }
    
    @IBAction func onClickPreviousBtn(_ sender: UIButton) {
    }
    
    @IBAction func onClickHomeBtn(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickNextBtn(_ sender: UIButton) {
    }
    
    @IBAction func onClickUpdate(_ sender: UIButton) {
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
