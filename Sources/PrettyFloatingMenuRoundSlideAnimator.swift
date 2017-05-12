//
//  PrettyFloatingMenuRoundSlideAnimator.swift
//  PrettyFloatingMenuView
//
//  Created by Oleksii Naboichenko on 5/12/17.
//  Copyright © 2017 Oleksii Naboichenko. All rights reserved.
//

open class PrettyFloatingMenuRoundSlideAnimator: PrettyFloatingMenuAnimator {
    
    // MARK: - Public Properties
    let radius: CGFloat = 100

    open var animationSpeed: Double = 0.1
    
    // MARK: - Initializers
    public init() { }
    
    // MARK: - PrettyFloatingMenuAnimator
    open func openMenuAnimation(_ itemViews: [PrettyFloatingMenuItemView], anchorPoint: CGPoint)  {
        var degree: CGFloat = 0
        var delay: TimeInterval = 0

        itemViews.enumerated().forEach { (index, itemView) in
            itemView.layer.transform = CATransform3DIdentity

            if index == 0 {
                //First item
                degree = degreesToRadians(180.0)
            } else if index == itemViews.count - 1 {
                //Last item
                degree = degreesToRadians(270.0)
            } else {
                degree = degreesToRadians(180 + (90.0 / CGFloat(itemViews.count-1)) * CGFloat(index))
            }
            
            itemView.center.x = radius * cos(degree) + anchorPoint.x
            itemView.center.y = radius * sin(degree) + anchorPoint.y
            
            
            itemView.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            
            UIView.animate(withDuration: 0.3, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: UIViewAnimationOptions(), animations: { () -> Void in
                itemView.alpha = 1
                itemView.layer.transform = CATransform3DIdentity
            })
            
            delay += animationSpeed
        }
    }
    
    open func closeMenuAnimation(_ itemViews: [PrettyFloatingMenuItemView], anchorPoint: CGPoint) {
        var delay = 0.0
        
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

extension PrettyFloatingMenuRoundSlideAnimator {
    
    fileprivate func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
        return degrees / 180.0 * CGFloat(Double.pi)
    }
}
