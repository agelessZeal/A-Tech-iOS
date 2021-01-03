//
//  PointTableViewCell.swift
//  A-Tech
//
//  Created by WuSongBai on 2019/12/28.
//  Copyright © 2019 atecheng. All rights reserved.
//

import UIKit

class PointTableViewCell: UITableViewCell {

    @IBOutlet weak var objectName: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var setpointLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initUI()
    }
    
    func initUI() {
        
        // Label UI...
        currentLabel.layer.cornerRadius = currentLabel.bounds.height / 2
        currentLabel.clipsToBounds = true
        
        setpointLabel.layer.cornerRadius = setpointLabel.bounds.height / 2
        setpointLabel.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
