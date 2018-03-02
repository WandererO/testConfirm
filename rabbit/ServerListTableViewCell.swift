//
//  ServerListTableViewCell.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/11.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import UIKit

class ServerListTableViewCell: UITableViewCell {
    @IBOutlet weak var serverName: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var calculaterLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
