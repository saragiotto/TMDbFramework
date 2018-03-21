//
//  ReleaseDateCell.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 18/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ReleaseDateCell: BaseCell {
    
    var releaseDate:UILabel

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.releaseDate = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.releaseDate = UILabel()
        super.init(coder: aDecoder)
        
        self.commomInit()
    }
    
    func commomInit() {

        self.releaseDate.textColor = UIColor.white
        self.releaseDate.font = UIFont.systemFont(ofSize: 14.0)
        self.releaseDate.textAlignment = .right
        self.releaseDate.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.releaseDate)
        
        self.setConstraints()
    }
    
    func setConstraints() {
        
        self.contentView.addConstraints([NSLayoutConstraint.init(item: self.releaseDate,
                                                                 attribute: .leading,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .leading,
                                                                 multiplier: 1.0,
                                                                 constant: 8.0),
                                         NSLayoutConstraint.init(item: self.releaseDate,
                                                                 attribute: .top,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .top,
                                                                 multiplier: 1.0,
                                                                 constant: 8.0),
                                         NSLayoutConstraint.init(item: self.releaseDate,
                                                                 attribute: .right,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .right,
                                                                 multiplier: 1.0,
                                                                 constant: -8.0),])
    }
    
    func configureWith(_ viewCellModel: ReleaseDateCellViewModel) {
        self.releaseDate.text = viewCellModel.releaseDate
        self.releaseDate.sizeToFit()
    }
}
