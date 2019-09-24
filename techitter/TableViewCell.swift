//
//  TableViewCell.swift
//  techitter
//
//  Created by 南伊織 on 2018/09/15.
//  Copyright © 2018年 LifeisTech. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var userName: UILabel!
    @IBOutlet var postText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    func labelAdd(indexPathNum: IndexPath, username: [String], post: [String]){
        userName.text = username[indexPathNum.row]
        postText.text = post[indexPathNum.row]
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
