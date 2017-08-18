//
//  CastCell.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 18/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import TMDbFramework

class CastCell: BaseCell {
    
    var castPhoto:UIImageView
    var castName:UILabel
    var castRole:UILabel

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.castPhoto = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
        self.castName = UILabel()
        self.castRole = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.castPhoto = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
        self.castName = UILabel()
        self.castRole = UILabel()
        
        super.init(coder: aDecoder)
        
        self.commomInit()
    }
    
    func commomInit() {
        
        self.castName.textColor = UIColor.white
        self.castName.font = UIFont.systemFont(ofSize: 10.0)
        self.castRole.textColor = UIColor.white
        self.castRole.font = UIFont.systemFont(ofSize: 10.0)
        
        self.castPhoto.backgroundColor = UIColor.clear
        self.castPhoto.contentMode = .scaleAspectFill
        self.castPhoto.clipsToBounds = true
        
        self.contentView.addSubview(self.castPhoto)
        self.contentView.addSubview(self.castName)
        self.contentView.addSubview(self.castRole)
        
        self.setConstraints()
    }
    
    override func layoutSubviews() {
        self.contentView.frame = self.bounds
        
        self.setConstraints()
    }
    
    func setConstraints() {
        
        self.contentView.addConstraints([NSLayoutConstraint.init(item: self.castPhoto,
                                                                 attribute: .left,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .left,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0),
                                         NSLayoutConstraint.init(item: self.castPhoto,
                                                                 attribute: .top,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .top,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0),])
        
        self.contentView.addConstraints([NSLayoutConstraint.init(item: self.castName,
                                                                 attribute: .left,
                                                                 relatedBy: .equal,
                                                                 toItem: self.castPhoto,
                                                                 attribute: .right,
                                                                 multiplier: 1.0,
                                                                 constant: 8.0),
                                         NSLayoutConstraint.init(item: self.castName,
                                                                 attribute: .centerY,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .centerY,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0),])
        
        self.contentView.addConstraints([NSLayoutConstraint.init(item: self.castRole,
                                                                 attribute: .left,
                                                                 relatedBy: .equal,
                                                                 toItem: self.castName,
                                                                 attribute: .right,
                                                                 multiplier: 1.0,
                                                                 constant: 8.0),
                                         NSLayoutConstraint.init(item: self.castRole,
                                                                 attribute: .centerY,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .centerY,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0),])
        
        
    }
    
    func configureWith(cast: TMDbCast) {
        
        if (cast.name != nil) {
            self.castName.text = cast.name!
        }
        
        if (cast.character != nil) {
            self.castRole.text = cast.character!
        }
        
        if (cast.profilePath != nil) {
            let tmdbPod = TMDb.sharedInstance
            tmdbPod.imageQuality = .medium
            
            tmdbPod.loadImageFor(path: cast.profilePath!, type: .profile) { image in
                
                self.castPhoto.image = (image?.image)!
                
                self.setNeedsLayout()
            }
        }
        
        

    }
}
