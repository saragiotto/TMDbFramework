//
//  BaseCell.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 18/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commomSuperInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commomSuperInit()
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func commomSuperInit() {
        
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.accessoryType = .none
        self.selectionStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
}
