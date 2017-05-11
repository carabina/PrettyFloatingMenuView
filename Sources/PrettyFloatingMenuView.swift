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
    open var items: [PrettyFloatingMenuItem]? {
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
        return center
    }
    
    private var itemViews: [PrettyFloatingMenuItemView] {
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
            //Tap on oneself
            toggle()
        } else {
            let itemSubviews = subviews.filter({ (view) -> Bool in
                return view is PrettyFloatingMenuItemView
            })
            
            if let itemSubviewIndex = itemSubviews.index(of: touchView), let item = items?[itemSubviewIndex] {
                //Tap on item view
                item.action?(item)
                
                //Close if need
                if closingAfterTapOnMenuItem == true {
                    close()
                }
            } else if closingAfterTapOnEmptySpace == true {
                //Close menu after tap on empty space
                close()
            }
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return true
    }
    
    // MARK: - Private Instance Methods
    private func updateOverlayView() {
        if state == .closed {
            backgroundColor = UIColor.blue
        } else {
            backgroundColor = UIColor.green
        }
    }
    
    private func updateSubviews() {
        //Remove subviews
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        //Add views
        items?.forEach({ (item) in
            let itemView = PrettyFloatingMenuItemView(item: item)
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
        
        animator?.openMenuAnimation(itemViews)
    }
    
    private func close() {
        state = .closed
        
        updateOverlayView()
        
        animator?.closeMenuAnimation(itemViews)
    }
}
