//
//  PrettyFloatingMenuSlideUpAnimator.swift
//  PrettyFloatingMenuView
//
//  Created by Oleksii Naboichenko on 5/11/17.
//  Copyright © 2017 Oleksii Naboichenko. All rights reserved.
//

open class PrettyFloatingMenuSlideUpAnimator: PrettyFloatingMenuAnimator {
    
    open func openMenuAnimation(_ itemViews: [PrettyFloatingMenuItemView])  {
        itemViews.forEach { (itemView) in
            itemView.center = CGPoint(x: 10, y: 200)
        }
    }
    
    open func closeMenuAnimation(_ itemViews: [PrettyFloatingMenuItemView]) {
        itemViews.forEach { (itemView) in
            itemView.center = CGPoint(x: 50, y: 100)
        }
    }
    
    public init() { }
}
