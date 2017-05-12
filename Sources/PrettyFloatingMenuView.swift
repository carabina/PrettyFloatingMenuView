
//
//  PrettyFloatingMenuView.swift
//  PrettyFloatingMenuView
//
//  Created by Oleksii Naboichenko on 5/11/17.
//  Copyright © 2017 Oleksii Naboichenko. All rights reserved.
//

import UIKit

public enum PrettyFloatingMenuState {
    case closed
    case open
}

open class PrettyFloatingMenuView: UIView {
    
    // MARK: - Public Properties
    open var itemViews: [PrettyFloatingMenuItemView]? {
        didSet {
            updateSubviews()
        }
    }
    
    open var closingAfterTapOnEmptySpace: Bool = true
    
    open var closingAfterTapOnMenuItem: Bool = true

    open var animator: PrettyFloatingMenuAnimator? = nil
    
    open private(set) var state: PrettyFloatingMenuState = .closed
    
    // MARK: - Private Properties
    private var anchorPoint: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private var presentedItemViews: [PrettyFloatingMenuItemView] {
        return subviews.filter({ (view) -> Bool in
            return view is PrettyFloatingMenuItemView
        }) as! [PrettyFloatingMenuItemView]
    }
    
    // MARK: - UIView
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        updateOverlayView()
        updateSubviews()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        UIView.setAnimationsEnabled(false)
        switch state {
        case .open:
            open()
        case .closed:
            close()
        }
        UIView.setAnimationsEnabled(true)
    }
    
    // MARK: - UIResponder
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let touch = touches.first, touch.tapCount == 1 else {
            return
        }
        
        guard let touchView = touch.view else {
            return
        }
        
        if touchView == self, bounds.contains(touch.location(in: self)) == true {
            //Detected tap on oneself
            toggle()
        } else if let itemView = touchView as? PrettyFloatingMenuItemView {
            //Detected tn item view
            itemView.action?(itemView)
            
            //Close if need
            if closingAfterTapOnMenuItem == true {
                close()
            }
        }
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for itemView in subviews {
            let itemViewPoint = itemView.convert(point, from: self)
            if itemView.bounds.contains(itemViewPoint) {
                return itemView.hitTest(itemViewPoint, with: event)
            }
        }
        
        let view = super.hitTest(point, with: event)
        
        if view == nil, state == .open, closingAfterTapOnEmptySpace == true {
            //Close menu after tap on empty space
            close()
        }
        
        return view
    }

    
    // MARK: - Private Instance Methods
    private func updateOverlayView() {
        clipsToBounds = false
        backgroundColor = UIColor.clear
        
        if state == .closed {
            backgroundColor = UIColor.blue
        } else {
            backgroundColor = UIColor.green
        }
    }
    
    private func updateSubviews() {
        //Remove subviews
        presentedItemViews.forEach { (itemView) in
            itemView.removeFromSuperview()
        }
        
        //Add views
        itemViews?.forEach({ (itemView) in
            self.addSubview(itemView)
        })
    }
    
    private func toggle() {
        switch state {
        case .closed:
            open()
        case .open:
            close()
        }
    }
    
    private func open() {
        state = .open
        
        updateOverlayView()
        
        guard let animator = animator, let itemViews = itemViews else {
            return
        }
        
        //Disable touches on items
        itemViews.forEach { (itemView) in
            itemView.isHidden = false
        }
        
        animator.openMenuAnimation(itemViews, anchorPoint: anchorPoint)
    }
    
    private func close() {
        state = .closed
        
        updateOverlayView()
        
        guard let animator = animator, let itemViews = itemViews else {
            return
        }

        //Enable touches on items
        itemViews.forEach { (itemView) in
            itemView.isHidden = true
        }
        
        animator.closeMenuAnimation(itemViews, anchorPoint: anchorPoint)
    }
}
