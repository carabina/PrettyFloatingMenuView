//
//  PrettyFloatingMenuItemView.swift
//  PrettyFloatingMenuView
//
//  Created by Oleksii Naboichenko on 5/11/17.
//  Copyright © 2017 Oleksii Naboichenko. All rights reserved.
//

// MARK: - PrettyFloatingMenuType
public enum PrettyFloatingMenuType {
    case square
    case circle
}

// MARK: - PrettyFloatingMenuItemView
open class PrettyFloatingMenuItemView: UIStackView {
    
    // MARK: - Public Properties
    open var attributedTitle: NSAttributedString? = nil {
        didSet {
            updateTitleLabel()
        }
    }
    
    open var iconImage: UIImage? = nil {
        didSet {
            updateIconImageView()
        }
    }
    
    open var iconSize: CGFloat = 42  {
        didSet {
            updateIconImageView()
        }
    }

    open var iconBackgroundColor: UIColor = UIColor.white  {
        didSet {
            updateIconImageView()
        }
    }

    open var type: PrettyFloatingMenuType = .circle  {
        didSet {
            updateIconImageView()
        }
    }
    
    open var action: ((PrettyFloatingMenuItemView) -> Void)? = nil
    
    // MARK: - Private Properties
    lazy private var titleLabel: UILabel? = {
        let label = UILabel()
        self.addArrangedSubview(label)
        return label
    }()
    
    lazy private var iconImageView: UIImageView? = {
        let imageView = UIImageView()
        self.addArrangedSubview(imageView)
        return imageView
    }()
    
    // MARK: - Initializers
    convenience public init() {
        self.init(frame: CGRect())
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        updateContent()
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
        
        updateContent()
    }
    
    private func updateContent() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        alignment = .fill
        backgroundColor = UIColor.clear
        
        updateTitleLabel()
        updateIconImageView()
    }
    
    private func updateIconImageView() {
        guard let imageView = iconImageView else {
            return
        }
        
        //Set content mode
        imageView.contentMode = .scaleAspectFit

        //Set image
        imageView.image = iconImage
        
        //Set background color
        backgroundColor = iconBackgroundColor
        
        //Set corner radius
        switch type {
        case .circle:
            layer.cornerRadius = iconSize / 2.0
        case .square:
            layer.cornerRadius = 0
        }
        
        //Remove old constraints
        NSLayoutConstraint.deactivate(imageView.constraints)
        
        //Add new constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let widthLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: iconSize)
        let heightLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: iconSize)
        NSLayoutConstraint.activate([widthLayoutConstraint, heightLayoutConstraint])
    }
    
    private func updateTitleLabel() {
        guard let label = titleLabel else {
            return
        }
        
        //Set title
        label.attributedText = attributedTitle
    }
}
