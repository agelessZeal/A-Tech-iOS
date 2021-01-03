//
//  ControlsViewController.swift
//  A-Tech
//
//  Created by WuSongBai on 2019/12/28.
//  Copyright © 2019 atecheng. All rights reserved.
//

import UIKit
import iOSDropDown

class ControlsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var controlTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.controlTableView.dequeueReusableCell(withIdentifier: "controlCell", for: indexPath)
        return cell
    }
    
    @IBAction func onClickPreviousBtn(_ sender: UIButton) {
    }
    
    @IBAction func onClickHomeBtn(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickNextBtn(_ sender: UIButton) {
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
