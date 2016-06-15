//
//  CampCell.swift
//  Campfire
//
//  Created by Matthew Turk on 6/15/16.
//  Copyright © 2016 Turk. All rights reserved.
//

import UIKit

class CampCell: UITableViewCell {
    @IBOutlet var campTitle: UILabel!
    @IBOutlet var campCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
