//
//  OverviewCell.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 18/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class OverviewCell: BaseCell {
    
    var overviewTextView: UITextView

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.overviewTextView = UITextView.init()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.overviewTextView = UITextView.init()
        super.init(coder: aDecoder)
        
        self.commomInit()
    }
    
    func commomInit() {

        self.overviewTextView.textColor = UIColor.lightText
        self.overviewTextView.font = UIFont.systemFont(ofSize: 12.0)
        self.overviewTextView.textAlignment = .justified
        self.overviewTextView.isEditable = false
        self.overviewTextView.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(self.overviewTextView)
        
        self.setConstraints()
    }

    override func layoutSubviews() {
        self.contentView.frame = self.bounds
        self.overviewTextView.frame = self.bounds
        
        self.setConstraints()
    }

    func setConstraints() {
        
        self.contentView.addConstraints([NSLayoutConstraint.init(item: self.overviewTextView,
                                                                 attribute: .left,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .left,
                                                                 multiplier: 1.0,
                                                                 constant: 16.0),
                                         NSLayoutConstraint.init(item: self.overviewTextView,
                                                                 attribute: .top,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .top,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0),
                                         NSLayoutConstraint.init(item: self.overviewTextView,
                                                                 attribute: .bottom,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .bottom,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0),
                                         NSLayoutConstraint.init(item: self.overviewTextView,
                                                                 attribute: .right,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .right,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0),])
    }

    func configureWith(overview: String?) {
        
        if (overview != nil) {
            self.overviewTextView.text = overview!
        }
    }
}
