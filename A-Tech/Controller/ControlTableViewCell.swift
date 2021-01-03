//
//  ControlTableViewCell.swift
//  A-Tech
//
//  Created by WuSongBai on 2019/12/28.
//  Copyright © 2019 atecheng. All rights reserved.
//

import UIKit
import iOSDropDown

class ControlTableViewCell: UITableViewCell {

    @IBOutlet weak var objectName: UILabel!
    @IBOutlet weak var cmdDropDown: DropDown!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
    }
    
    func initUI() {
        
        cmdDropDown.optionArray = ["Auto", "On", "Off"]
        cmdDropDown.optionIds = [1, 2, 3]
//        cmdDropDown.didSelect { (selectedText, index, id) in
//            
//        }
        statusLabel.layer.cornerRadius = statusLabel.bounds.height / 2
        statusLabel.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
