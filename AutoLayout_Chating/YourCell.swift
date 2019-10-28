//
//  YourCell.swift
//  AutoLayout_Chating
//
//  Created by 양팀장(iMac) on 2019. 10. 28..
//  Copyright © 2019년 양팀장(iMac). All rights reserved.
//

import UIKit

class YourCell: UITableViewCell {

    @IBOutlet weak var yourTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
