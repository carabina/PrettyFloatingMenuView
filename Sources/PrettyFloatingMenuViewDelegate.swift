//
//  PrettyFloatingMenuViewDelegate.swift
//  PrettyFloatingMenuView
//
//  Created by Oleksii Naboichenko on 5/26/17.
//  Copyright © 2017 Oleksii Naboichenko. All rights reserved.
//

import Foundation

// MARK: - PrettyFloatingMenuViewDelegate
public protocol PrettyFloatingMenuViewDelegate: class {
    func willShowItems(_ floatingMenuView: PrettyFloatingMenuView)
    func willHideItems(_ floatingMenuView: PrettyFloatingMenuView)
}

extension PrettyFloatingMenuViewDelegate {
    
    func willShowItems(_ floatingMenuView: PrettyFloatingMenuView) {
    }
    
    func willHideItems(_ floatingMenuView: PrettyFloatingMenuView) {
    }
}
