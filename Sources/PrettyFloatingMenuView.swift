
//
//  PrettyFloatingMenuView.swift
//  PrettyFloatingMenuView
//
//  Created by Oleksii Naboichenko on 5/11/17.
//  Copyright © 2017 Oleksii Naboichenko. All rights reserved.
//

import UIKit

// MARK: - PrettyFloatingMenuState
public enum PrettyFloatingMenuState {
    case closed
    case opened
}

// MARK: - PrettyFloatingMenuView
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
    private lazy var menuButtonImageView: UIImageView = {
        let imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)

        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        return imageView
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView(frame: self.bounds)
        self.addSubview(view)
        
//        view.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
//        view.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor).isActive = true
//        view.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: 1).isActive = true
//        view.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: 1).isActive = true
        
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
        if bounds.contains(point) {
            return self
        }
        
        for itemView in subviews {
            let itemViewPoint = itemView.convert(point, from: self)
            if itemView.bounds.contains(itemViewPoint) {
                return itemView.hitTest(itemViewPoint, with: event)
            }
        }
        
        if state == .opened, closingAfterTapOnEmptySpace == true {
            //Close menu after tap on empty space
            close()
        }
        
        return super.hitTest(point, with: event)
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
        
        menuButtonImageView.image = menuImages[state] ?? nil
        
        menuButtonImageView.backgroundColor = menuBackgroundColors[state] ?? nil
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
