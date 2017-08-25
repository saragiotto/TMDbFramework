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
        
        self.releaseDate.textColor = UIColor.lightText
        self.releaseDate.font = UIFont.systemFont(ofSize: 14.0)
        self.releaseDate.textAlignment = .right
        self.releaseDate.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.releaseDate)
        
        self.setConstraints()
    }

    func setConstraints() {
        
        self.contentView.addConstraints([NSLayoutConstraint.init(item: self.releaseDate,
                                                                 attribute: .right,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .right,
                                                                 multiplier: 1.0,
                                                                 constant: 16.0),
                                         NSLayoutConstraint.init(item: self.releaseDate,
                                                                 attribute: .centerY,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .centerY,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0),])
    }
    
    func configureWith(releaseDate: String?) {
        
        if (releaseDate != nil) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let releaseDateFormatted = dateFormatter.date(from: releaseDate!)
            
            let newDateFormat = DateFormatter()
            newDateFormat.dateStyle = .medium
        
            self.releaseDate.text = "Release Date " + newDateFormat.string(from: releaseDateFormatted!)
        } else {
            self.releaseDate.text = "To be announced"
        }
        
        self.releaseDate.sizeToFit()
    }
}
