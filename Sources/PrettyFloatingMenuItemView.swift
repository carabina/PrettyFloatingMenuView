//
//  PrettyFloatingMenuItemView.swift
//  PrettyFloatingMenuView
//
//  Created by Oleksii Naboichenko on 5/11/17.
//  Copyright © 2017 Oleksii Naboichenko. All rights reserved.
//

import PrettyCircleView

// MARK: - PrettyFloatingMenuItemView
public enum PrettyFloatingMenuItemViewTitleVerticalPosition {
    case top
    case center
    case bottom
}

// MARK: - PrettyFloatingMenuItemView
open class PrettyFloatingMenuItemView: UIStackView {
    
    // MARK: - Public Properties
    open var title: NSAttributedString? = nil {
        didSet {
            updateTitleLabel()
        }
    }
    
    open var titleVerticalPosition: PrettyFloatingMenuItemViewTitleVerticalPosition = .center {
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

    open var horisontalSpacing: CGFloat {
        get {
            return spacing
        }
        
        set {
            spacing = newValue
        }
    }
    
    open var action: ((PrettyFloatingMenuItemView) -> Void)? = nil
    
    // MARK: - Private Properties
    lazy private var titleLabel: UILabel? = {
        let label = UILabel()
        self.addArrangedSubview(label)
        return label
    }()
    
    lazy private var iconCircleView: PrettyCircleView? = {
        let circleView = PrettyCircleView()
        circleView.isUserInteractionEnabled = true
        self.addArrangedSubview(circleView)
        return circleView
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
        backgroundColor = UIColor.clear
        
        updateTitleLabel()
        updateIconImageView()
    }
    
    private func updateIconImageView() {
        guard let iconCircleView = iconCircleView else {
            return
        }
        
        //Set image
        iconCircleView.contentImage = iconImage
        
        //Set background color
        iconCircleView.contentBackgroundColor = iconBackgroundColor
        
        //Remove old constraints
        NSLayoutConstraint.deactivate(iconCircleView.constraints)
        
        //Add new constraints
        iconCircleView.translatesAutoresizingMaskIntoConstraints = false
        let widthLayoutConstraint = NSLayoutConstraint(item: iconCircleView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: iconSize)
        let heightLayoutConstraint = NSLayoutConstraint(item: iconCircleView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: iconSize)
        NSLayoutConstraint.activate([widthLayoutConstraint, heightLayoutConstraint])
    }
    
    private func updateTitleLabel() {
        guard let label = titleLabel else {
            return
        }
        
        //Set title
        label.attributedText = title
        
        switch titleVerticalPosition {
        case .top:
            alignment = .firstBaseline
        case .center:
            alignment = .center
        case .bottom:
            alignment = .lastBaseline
        }
    }
}
