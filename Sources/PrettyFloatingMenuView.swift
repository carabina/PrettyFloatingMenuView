
//
//  PrettyFloatingMenuView.swift
//  PrettyFloatingMenuView
//
//  Created by Oleksii Naboichenko on 5/11/17.
//  Copyright © 2017 Oleksii Naboichenko. All rights reserved.
//

import UIKit
import PrettyCircleView

// MARK: - PrettyFloatingMenuState
public enum PrettyFloatingMenuState {
    case closed
    case opened
}

// MARK: - PrettyFloatingMenuView
open class PrettyFloatingMenuView: PrettyCircleView {
    
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
    private lazy var menuCircleView: PrettyCircleView = {
        let circleView = PrettyCircleView(frame: self.bounds)
        self.addSubview(circleView)
        return circleView
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView(frame: self.bounds)
        self.addSubview(view)
        return view
    }()
    
    private var menuImages: [PrettyFloatingMenuState: UIImage?] = [:]
    
    private var menuBackgroundColors: [PrettyFloatingMenuState: UIColor?] = [:]

    private var overlayColors: [PrettyFloatingMenuState: UIColor?] = [:]
    
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
        
        updateMenuButtonImageView()
        updateOverlayView()
        updateSubviews()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        UIView.setAnimationsEnabled(false)
        switch state {
        case .opened:
            open()
        case .closed:
            close()
        }
        UIView.setAnimationsEnabled(true)
    }
    
    // MARK: - UIResponder
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first, touch.tapCount == 1, let touchView = touch.view else {
            return
        }
        
        if let itemView = touchView as? PrettyFloatingMenuItemView {
            UIView.animate(withDuration: 0.05, animations: { 
                itemView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1)
            })
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let touch = touches.first, touch.tapCount == 1, let touchView = touch.view else {
            return
        }
        
        if touchView == self, bounds.contains(touch.location(in: self)) == true {
            //Detected tap on oneself
            toggle()
        } else if let itemView = touchView as? PrettyFloatingMenuItemView {
            UIView.animate(withDuration: 0.05, animations: {
                itemView.layer.transform = CATransform3DIdentity
            }, completion: { (_) in
                //Close if need
                if self.closingAfterTapOnMenuItem == true {
                    self.close()
                }
                
                itemView.action?(itemView)
            })
        }
    }
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesCancelled(touches, with: event)
    }
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, touch.tapCount == 1, let touchView = touch.view else {
            return
        }
        
        if let itemView = touchView as? PrettyFloatingMenuItemView {
            UIView.animate(withDuration: 0.05, animations: {
                itemView.layer.transform = CATransform3DIdentity
            })
        }
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if bounds.contains(point) {
            return self
        }
        
        for itemView in presentedItemViews {
            let itemViewPoint = itemView.convert(point, from: self)
            if itemView.bounds.contains(itemViewPoint) {
                return itemView
            }
        }
        
        if state == .opened, closingAfterTapOnEmptySpace == true {
            //Close menu after tap on empty space
            close()
        }
        
        return nil
    }
    
    // MARK: - Public Instance Methods
    open func setImage(_ image: UIImage?, forState state: PrettyFloatingMenuState) {
        menuImages[state] = image
        
        updateMenuButtonImageView()
    }
    
    open func setBackgroundColor(_ color: UIColor?, forState state: PrettyFloatingMenuState) {
        menuBackgroundColors[state] = color
        
        updateMenuButtonImageView()
    }
    
    open func setOverlayColor(_ color: UIColor?, forState state: PrettyFloatingMenuState) {
        overlayColors[state] = color
        
        updateOverlayView()
    }
    
    
    // MARK: - Private Instance Methods
    private func updateMenuButtonImageView() {
        clipsToBounds = false
        backgroundColor = UIColor.clear
        
        menuCircleView.contentImage = menuImages[state] ?? nil
        
        menuCircleView.contentBackgroundColor = menuBackgroundColors[state] ?? nil
    }
    
    private func updateOverlayView() {
        sendSubview(toBack: overlayView)
        
        switch state {
        case .closed:
            overlayView.frame = CGRect()
        case .opened:
            guard let superview = superview else {
                return
            }
            
            overlayView.frame = superview.convert(superview.frame, to: self)
        }

        overlayView.backgroundColor = overlayColors[state] ?? nil
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
        case .opened:
            close()
        }
    }
    
    private func open() {
        state = .opened
        
        updateMenuButtonImageView()
        updateOverlayView()
        
        guard let animator = animator, let itemViews = itemViews else {
            return
        }
        
        //Disable touches on items
        itemViews.forEach { (itemView) in
            itemView.isUserInteractionEnabled = true
        }
        
        animator.openMenuAnimation(itemViews, anchorPoint: anchorPoint)
    }
    
    private func close() {
        state = .closed
        
        updateMenuButtonImageView()
        updateOverlayView()
        
        guard let animator = animator, let itemViews = itemViews else {
            return
        }

        //Enable touches on items
        itemViews.forEach { (itemView) in
            itemView.isUserInteractionEnabled = false
        }
        
        animator.closeMenuAnimation(itemViews, anchorPoint: anchorPoint)
    }
}
