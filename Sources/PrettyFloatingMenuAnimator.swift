//
//  PrettyFloatingMenuAnimator.swift
//  PrettyFloatingMenuView
//
//  Created by Oleksii Naboichenko on 5/11/17.
//  Copyright © 2017 Oleksii Naboichenko. All rights reserved.
//

import Foundation

public protocol PrettyFloatingMenuAnimator {
    
    func openMenuAnimation(_ itemViews: [PrettyFloatingMenuItemView], anchorPoint: CGPoint)
    func closeMenuAnimation(_ itemViews: [PrettyFloatingMenuItemView], anchorPoint: CGPoint)
}
