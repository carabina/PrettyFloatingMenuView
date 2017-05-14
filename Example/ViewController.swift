//
//  ViewController.swift
//  Example
//
//  Created by Oleksii Naboichenko on 5/11/17.
//  Copyright © 2017 Oleksii Naboichenko. All rights reserved.
//

import UIKit
import PrettyFloatingMenuView

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var menuView: PrettyFloatingMenuView!
    @IBOutlet weak var roundMenuView: PrettyFloatingMenuView!

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareRoundMenuView()
        prepareMenuView()
    }

    // MARK: - Private Instance Methods
    private func prepareMenuView() {
        let firstItemView = PrettyFloatingMenuItemView()
        firstItemView.attributedTitle = NSAttributedString(string: "Test Item 1")
        firstItemView.iconImage = UIImage(named: "community-icon")
        firstItemView.action = { (item) in
            print(item.attributedTitle!.string)
        }
        
        let secondItemView = PrettyFloatingMenuItemView()
        secondItemView.attributedTitle = NSAttributedString(string: "Test Item 2")
        secondItemView.iconImage = UIImage(named: "trophy-icon")
        secondItemView.action = { (item) in
            print(item.attributedTitle!.string)
        }
        
        let thirdItemView = PrettyFloatingMenuItemView()
        thirdItemView.attributedTitle = NSAttributedString(string: "Test Item 3")
        thirdItemView.iconImage = UIImage(named: "alert-icon")
        thirdItemView.action = { (item) in
            print(item.attributedTitle!.string)
        }
        
        menuView.itemViews = [firstItemView, secondItemView, thirdItemView]
        menuView.setImage(UIImage(named: "menu-icon"), forState: .closed)
        menuView.setImage(UIImage(named: "close-icon"), forState: .opened)
        menuView.setBackgroundColor(UIColor.yellow, forState: .closed)
        menuView.setBackgroundColor(UIColor.blue, forState: .opened)
        menuView.setOverlayColor(UIColor.green.withAlphaComponent(0.5), forState: .opened)
        menuView.animator = PrettyFloatingMenuSlideUpAnimator()
    }
    
    private func prepareRoundMenuView() {
        let firstItemView = PrettyFloatingMenuItemView()
        firstItemView.attributedTitle = NSAttributedString(string: "Test Item 1")
        firstItemView.iconImage = UIImage(named: "community-icon")
        firstItemView.action = { (item) in
            print(item.attributedTitle!.string)
        }
        
        let secondItemView = PrettyFloatingMenuItemView()
        secondItemView.attributedTitle = NSAttributedString(string: "Test Item 2")
        secondItemView.iconImage = UIImage(named: "trophy-icon")
        secondItemView.action = { (item) in
            print(item.attributedTitle!.string)
        }
        
        let thirdItemView = PrettyFloatingMenuItemView()
        thirdItemView.attributedTitle = NSAttributedString(string: "Test Item 3")
        thirdItemView.iconImage = UIImage(named: "alert-icon")
        thirdItemView.action = { (item) in
            print(item.attributedTitle!.string)
        }
        
        roundMenuView.itemViews = [firstItemView, secondItemView, thirdItemView]
        roundMenuView.animator = PrettyFloatingMenuRoundSlideAnimator()
    }

}

