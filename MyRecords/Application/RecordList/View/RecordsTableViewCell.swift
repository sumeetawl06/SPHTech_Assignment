//
//  RecordsTableViewCell.swift
//  MyRecords
//
//  Created by Sumeet Agarwal on 2/8/20.
//  Copyright © 2020 Sumeet Agarwal. All rights reserved.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var consumptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
