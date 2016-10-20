//
//  RightTableViewCell.swift
//  微诉
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class RightTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var touxiang: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        /**
         *设置头像的边框粗细
         *设置头像的边框颜色
         */
        touxiang.layer.masksToBounds = true
        touxiang.layer.borderWidth = 2
        touxiang.layer.borderColor = UIColor.whiteColor().CGColor
        touxiang.layer.cornerRadius = 24
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
