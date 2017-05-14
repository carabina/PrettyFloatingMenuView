//
//  PrettyFloatingMenuSlideUpAnimator.swift
//  PrettyFloatingMenuView
//
//  Created by Oleksii Naboichenko on 5/11/17.
//  Copyright © 2017 Oleksii Naboichenko. All rights reserved.
//

open class PrettyFloatingMenuSlideUpAnimator: PrettyFloatingMenuAnimator {
    
    // MARK: - Public Properties
    open var verticalSpacing: CGFloat = 10.0
    
    open var animationSpeed: Double = 0.1
    
    // MARK: - Initializers
    public init() { }
    
    // MARK: - PrettyFloatingMenuAnimator
    open func openMenuAnimation(_ itemViews: [PrettyFloatingMenuItemView], anchorPoint: CGPoint)  {
        var height: CGFloat = 0
        var delay: TimeInterval = 0
        
        itemViews.forEach { (itemView) in
            itemView.layer.transform = CATransform3DIdentity

            let itemSize = itemView.frame.size

            height += itemSize.height + verticalSpacing

            itemView.frame.origin.x = -itemSize.width + itemView.iconSize / 2 + anchorPoint.x
            itemView.frame.origin.y = -height
            itemView.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            
            UIView.animate(withDuration: 0.3, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: UIViewAnimationOptions(), animations: { () -> Void in
                itemView.alpha = 1
                itemView.layer.transform = CATransform3DIdentity
            })
            
            delay += animationSpeed
        }
    }
    
    open func closeMenuAnimation(_ itemViews: [PrettyFloatingMenuItemView], anchorPoint: CGPoint) {
        var delay: TimeInterval = 0
        
        itemViews.reversed().forEach { (itemView) in
           UIView.animate(withDuration: 0.15, delay: delay, options: [], animations: { () -> Void in
                itemView.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
                itemView.alpha = 0
            }, completion: { (_) in
                itemView.center = anchorPoint
            })
            
            delay += animationSpeed
        }
    }
}
