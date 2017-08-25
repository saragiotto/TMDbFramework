//
//  CastCell.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 18/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import TMDbFramework
import AlamofireImage

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
    
    func configureWith(cast: TMDbCast) {
        
        if (cast.name != nil) {
            self.castName.text = cast.name!
            self.castName.sizeToFit()
        }
        
        if (cast.character != nil) {
            self.castRole.text = cast.character!
            self.castRole.sizeToFit()
        }
        
        if (cast.profilePath != nil) {
            
            let tmdbViewModel = MovieListViewModel()
            let size = self.castPhoto.bounds.size
            
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: size,
                radius: 8.0
            )
            
            tmdbViewModel.tmdbModel.imageURLFor(path: cast.profilePath!, type: .profile) { stringProfilePath in
                
                self.castPhoto.af_setImage(withURL: URL(string: stringProfilePath)!,
                                            filter: filter,
                                   imageTransition: .crossDissolve(0.2))
            }
        } else {
            guard let gender = cast.gender else {
                self.castPhoto.image = UIImage(named: "manProfile.png")
                return
            }
            
            switch gender {
            case 1: self.castPhoto.image = UIImage(named: "womanProfile.png")
            default: self.castPhoto.image = UIImage(named: "manProfile.png")
            }
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.castPhoto.af_cancelImageRequest()
        self.castPhoto.layer.removeAllAnimations()
        self.castPhoto.image = nil
    }
}
