//
//  CastCell.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 18/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import TMDbFramework
import Kingfisher

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
        //self.castPhoto = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
        self.castPhoto = UIImageView()
        self.castName = UILabel()
        self.castRole = UILabel()
        
        super.init(coder: aDecoder)
        
        self.commomInit()
    }
    
    func commomInit() {
        
        self.castName.textColor = UIColor.white
        self.castName.font = UIFont.systemFont(ofSize: 12.0)
        self.castName.translatesAutoresizingMaskIntoConstraints = false
        self.castRole.textColor = UIColor.lightGray
        self.castRole.font = UIFont.systemFont(ofSize: 12.0)
        self.castRole.translatesAutoresizingMaskIntoConstraints = false
        
        self.castPhoto.backgroundColor = UIColor.clear
        self.castPhoto.contentMode = .scaleAspectFill
        self.castPhoto.layer.cornerRadius = 8.0
        self.castPhoto.clipsToBounds = true
        self.castPhoto.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.castPhoto)
        self.contentView.addSubview(self.castName)
        self.contentView.addSubview(self.castRole)
        
        self.setConstraints()
    }
    
    func setConstraints() {
        
        self.contentView.addConstraints([NSLayoutConstraint.init(item: self.castPhoto,
                                                                 attribute: .left,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .left,
                                                                 multiplier: 1.0,
                                                                 constant: 4.0),
                                         NSLayoutConstraint.init(item: self.castPhoto,
                                                                 attribute: .top,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .top,
                                                                 multiplier: 1.0,
                                                                 constant: 4.0),
                                         NSLayoutConstraint.init(item: self.castPhoto,
                                                                 attribute: .height,
                                                                 relatedBy: .equal,
                                                                 toItem: nil,
                                                                 attribute: .notAnAttribute,
                                                                 multiplier: 1.0,
                                                                 constant: 44.0),
                                         NSLayoutConstraint.init(item: self.castPhoto,
                                                                 attribute: .width,
                                                                 relatedBy: .equal,
                                                                 toItem: nil,
                                                                 attribute: .notAnAttribute,
                                                                 multiplier: 1.0,
                                                                 constant: 44.0),])
        
        self.contentView.addConstraints([NSLayoutConstraint.init(item: self.castName,
                                                                 attribute: .left,
                                                                 relatedBy: .equal,
                                                                 toItem: self.castPhoto,
                                                                 attribute: .right,
                                                                 multiplier: 1.0,
                                                                 constant: 8.0),
                                         NSLayoutConstraint.init(item: self.castName,
                                                                 attribute: .top,
                                                                 relatedBy: .equal,
                                                                 toItem: self.castPhoto,
                                                                 attribute: .top,
                                                                 multiplier: 1.0,
                                                                 constant: 4.0),])
        
        self.contentView.addConstraints([NSLayoutConstraint.init(item: self.castRole,
                                                                 attribute: .left,
                                                                 relatedBy: .equal,
                                                                 toItem: self.castPhoto,
                                                                 attribute: .right,
                                                                 multiplier: 1.0,
                                                                 constant: 8.0),
                                         NSLayoutConstraint.init(item: self.castRole,
                                                                 attribute: .bottom,
                                                                 relatedBy: .equal,
                                                                 toItem: self.castPhoto,
                                                                 attribute: .bottom,
                                                                 multiplier: 1.0,
                                                                 constant: -4.0),])
        
        
    }
    
    func configureWith(_ viewCellModel: CastCellViewModel) {
        
        self.castName.text = viewCellModel.name
        self.castName.sizeToFit()
        self.castRole.text = viewCellModel.character
        self.castRole.sizeToFit()
        
        if (!viewCellModel.profilePath.isEmpty) {
            TMDb.shared.imageURLFor(path: viewCellModel.profilePath, type: .profile) { stringProfilePath in
                
                self.castPhoto.kf.setImage(with: URL(string: stringProfilePath)!,
                                        options:[.transition(.fade(0.2))])
            }
        } else {
            self.castPhoto.image = UIImage(named: (viewCellModel.gender == 1) ? "manProfile.png" : "womanProfile.png")
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.castPhoto.kf.cancelDownloadTask()
        self.castPhoto.layer.removeAllAnimations()
        self.castPhoto.image = nil
    }
}
