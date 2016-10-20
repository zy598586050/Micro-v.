//
//  DetailsTableViewCell.swift
//  微诉
//
//  Created by ibokan on 16/7/19.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /**
         *设置头像的边框粗细
         *设置头像的边框颜色
         */
        img.layer.masksToBounds = true
        img.layer.borderWidth = 2
        img.layer.borderColor = UIColor.whiteColor().CGColor
        img.layer.cornerRadius = 24
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
