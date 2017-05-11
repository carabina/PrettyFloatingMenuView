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
    
    open private(set) var state: PrettyFloatingMenuState = .closed
    
    // MARK: - Private Properties
    private var anchorPoint: CGPoint {
        return center
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
            //Tap to oneself
            toggle()
        } else if let subviewIndex = subviews.index(of: touchView) {
            //Tap on subview
            print(subviewIndex)
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
        
        items?.forEach({ (item) in
            let itemView = PrettyFloatingMenuItemView(item: item)
            self.addSubview(itemView)
        })
    }
    
    private func toggle() {
        if state == .closed {
            state = .open
        } else {
            state = .closed
        }
        
        updateOverlayView()
    }
}
