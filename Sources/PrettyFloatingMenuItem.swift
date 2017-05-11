//
//  PrettyFloatingMenuItem.swift
//  PrettyFloatingMenuView
//
//  Created by Oleksii Naboichenko on 5/11/17.
//  Copyright © 2017 Oleksii Naboichenko. All rights reserved.
//

import UIKit

// MARK: - PrettyFloatingMenuItemView
class PrettyFloatingMenuItemView: UIStackView {
    
    // MARK: - Internal Properties
    var titleLabel: UILabel?
    
    var iconImageView: UIImageView?
    
    // MARK: - Initializers
    convenience init(item: PrettyFloatingMenuItem) {
        self.init(frame: CGRect())
        
        //Prepare StackView
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        alignment = .fill
        
        //Prepare iconImageView
        iconImageView!.contentMode = .scaleAspectFit
        iconImageView!.image = item.iconImage
        
        iconImageView!.translatesAutoresizingMaskIntoConstraints = false
        
        let widthLayoutConstraint = NSLayoutConstraint(item: iconImageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: item.iconSize)
        let heightLayoutConstraint = NSLayoutConstraint(item: iconImageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: item.iconSize)
        NSLayoutConstraint.activate([widthLayoutConstraint, heightLayoutConstraint])
        
        //Prepare titleLabel
        titleLabel?.attributedText = item.attributedTitle
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Create titleLabel
        titleLabel = UILabel()
        addArrangedSubview(titleLabel!)
        
        //Create iconImageView
        iconImageView = UIImageView()
        addArrangedSubview(iconImageView!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
