//
//  OverviewCell.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 18/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class OverviewCell: BaseCell {
    
    var overviewTextView: UILabel

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.overviewTextView = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.overviewTextView = UILabel()
        super.init(coder: aDecoder)
        
        self.commomInit()
    }
    
    func commomInit() {
        self.overviewTextView = OverviewCell.labelConfiguration()
        self.contentView.addSubview(self.overviewTextView)
        self.setConstraints()
    }
    
    static func labelConfiguration() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.lightText
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    static func getOverviewCellSize(for viewCellModel: OverviewCellViewModel) -> CGSize {
        let autoLayoutLabel = OverviewCell.labelConfiguration()
        let margins = CGFloat(16.0)
        autoLayoutLabel.text = viewCellModel.overview
        let screenSize = UIScreen.main.bounds
        let labelSize = autoLayoutLabel.sizeThatFits(CGSize(width: Double(screenSize.width - margins), height: Double(MAXFLOAT)))
        
        return CGSize(width: screenSize.width - margins, height: labelSize.height + margins)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func setConstraints() {
        
        self.contentView.addConstraints([NSLayoutConstraint.init(item: self.overviewTextView,
                                                                 attribute: .left,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .left,
                                                                 multiplier: 1.0,
                                                                 constant: 8.0),
                                         NSLayoutConstraint.init(item: self.overviewTextView,
                                                                 attribute: .top,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .top,
                                                                 multiplier: 1.0,
                                                                 constant: 8.0),
                                         NSLayoutConstraint.init(item: self.overviewTextView,
                                                                 attribute: .right,
                                                                 relatedBy: .equal,
                                                                 toItem: self.contentView,
                                                                 attribute: .right,
                                                                 multiplier: 1.0,
                                                                 constant: -8.0)])
    }

    func configureWith(_ viewCellModel: OverviewCellViewModel) {
        self.overviewTextView.text = viewCellModel.overview
        self.overviewTextView.sizeToFit()
        self.contentView.sizeToFit()
    }
}
