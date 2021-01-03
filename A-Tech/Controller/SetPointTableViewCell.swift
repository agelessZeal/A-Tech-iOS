//
//  SetPointTableViewCell.swift
//  A-Tech
//
//  Created by WuSongBai on 2019/12/28.
//  Copyright © 2019 atecheng. All rights reserved.
//

import UIKit
import iOSDropDown

class SetPointTableViewCell: UITableViewCell {

    @IBOutlet weak var objectName: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var setpointDropDown: DropDown!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
    }
    
    func initUI() {
        
        setpointDropDown.optionArray = ["24C", "Auto"]
        setpointDropDown.optionIds = [1, 2]
        // Label UI...
        currentLabel.layer.cornerRadius = currentLabel.bounds.height / 2
        currentLabel.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
