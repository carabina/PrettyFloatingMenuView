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

// MARK: - PrettyFloatingMenuItem
open class PrettyFloatingMenuItem {
    
    // MARK: - Public Properties
    open var attributedTitle: NSAttributedString? = nil
    open var iconImage: UIImage? = nil
    open var iconSize: CGFloat = 42
    open var iconBackgroundColor: UIColor = UIColor.white
    open var type: PrettyFloatingMenuType = .circle
    open var action: ((PrettyFloatingMenuItem) -> Void)? = nil
    
    // MARK: - Initializers
    public init() {}
}
