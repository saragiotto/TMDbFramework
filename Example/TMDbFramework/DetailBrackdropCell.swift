//
//  DetailBrackdropCell.swift
//  TMDbFramework
//
//  Created by Leonardo Saragiotto on 8/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class DetailBrackdropCell: UITableViewCell {
    
    var backdropImageView:UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backdropImageView = UIImageView()
        
        self.contentView.addSubview(self.backdropImageView!)
        
        self.contentView.addConstraints([NSLayoutConstraint.init(item: self.backdropImageView,
                                                            attribute: .left,
                                                            relatedBy: .equal,
                                                               toItem: self.contentView,
                                                            attribute: .left,
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
                                                                   constant: 0.0),
                                        NSLayoutConstraint.init(item: self.backdropImageView,
                                                                    attribute: .right,
                                                                    relatedBy: .equal,
                                                                    toItem: self.contentView,
                                                                    attribute: .right,
                                                                    multiplier: 1.0,
                                                                    constant: 0.0), ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(image: UIImage) {
    
    }

}
