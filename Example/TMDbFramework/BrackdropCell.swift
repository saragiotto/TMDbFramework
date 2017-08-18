//
//  BrackdropCell.swift
//  TMDbFramework
//
//  Created by Leonardo Saragiotto on 8/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import TMDbFramework

class BrackdropCell: BaseCell {
    
    var backdropImageView:UIImageView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        backdropImageView = UIImageView.init()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        backdropImageView = UIImageView.init()
        super.init(coder: aDecoder)
        
        self.commomInit()
    }
    
    func commomInit() {
        backdropImageView.backgroundColor = UIColor.clear
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.clipsToBounds = true
        
        self.contentView.addSubview(self.backdropImageView)
        
        self.setConstraints()
    }
    
    override func layoutSubviews() {
        self.contentView.frame = self.bounds
        self.backdropImageView.frame = self.bounds
        
    }
    
    func setConstraints() {
        
        self.contentView.addConstraints([NSLayoutConstraint.init(item: self.backdropImageView,
                                                                 attribute: .left,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .left,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0),
                                         NSLayoutConstraint.init(item: self.backdropImageView,
                                                                 attribute: .right,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .right,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0),
                                         NSLayoutConstraint.init(item: self.backdropImageView,
                                                                 attribute: .top,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .top,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0),
                                         NSLayoutConstraint.init(item: self.backdropImageView,
                                                                 attribute: .bottom,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .bottom,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0),])
    }
    
    func configureWith(imagePath: String) {
        
        let tmdbPod = TMDb.sharedInstance
        tmdbPod.imageQuality = .medium
        
        tmdbPod.loadImageFor(path: imagePath, type: .backdrop) { image in
            
            self.backdropImageView.image = (image?.image)!
            
            self.setNeedsLayout()
        }
    }

}
