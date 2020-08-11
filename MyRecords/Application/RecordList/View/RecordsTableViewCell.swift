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
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recordMainImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        
//        self.recordMainImage.image = UIImage(named: data?.image ?? "")
//        self.titleLabel.text = data?.
//        self.typeLabel.text = data?.type
//        self.timeLabel.text = data?.time?.description
    }
    
    var data: Record? {
        didSet{
            self.setupUI()
        }
    }
    
    
}
