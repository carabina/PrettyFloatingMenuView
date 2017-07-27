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

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareMenuView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // toggle test
        menuView.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self] in
            guard let this = self else { return }
            this.menuView.toggle()
        }
    }

    // MARK: - Private Instance Methods
    private func prepareMenuView() {
        let firstItemView = PrettyFloatingMenuItemView()
        firstItemView.title = NSAttributedString(string: "Test Item 1")
        firstItemView.iconImage = UIImage(named: "community-icon")
        firstItemView.action = { (item) in
            print(item.title!.string)
        }
        
//        let secondItemView = PrettyFloatingMenuItemView()
//        secondItemView.title = NSAttributedString(string: "Test Item 2")
//        secondItemView.iconImage = UIImage(named: "trophy-icon")
//        secondItemView.action = { (item) in
//            print(item.title!.string)
//        }
//        
//        let thirdItemView = PrettyFloatingMenuItemView()
//        thirdItemView.title = NSAttributedString(string: "Test Item 3")
//        thirdItemView.iconImage = UIImage(named: "alert-icon")
//        thirdItemView.action = { (item) in
//            print(item.title!.string)
//        }
//        
//        let fourthItemView = PrettyFloatingMenuItemView()
//        fourthItemView.title = NSAttributedString(string: "Test Item 4")
//        fourthItemView.iconImage = UIImage(named: "community-icon")
//        fourthItemView.action = { (item) in
//            print(item.title!.string)
//        }
//        fourthItemView.titleVerticalPosition = .top
//        
//        let fifthItemView = PrettyFloatingMenuItemView()
//        fifthItemView.title = NSAttributedString(string: "Test Item 5")
//        fifthItemView.iconImage = UIImage(named: "trophy-icon")
//        fifthItemView.action = { (item) in
//            print(item.title!.string)
//        }
//        fifthItemView.titleVerticalPosition = .top
        
//        menuView.itemViews = [firstItemView, secondItemView, thirdItemView, fourthItemView, fifthItemView]
        menuView.itemViews = [firstItemView]
        menuView.setImage(UIImage(named: "menu-icon"), forState: .closed)
        menuView.setImage(UIImage(named: "close-icon"), forState: .opened)
        menuView.setImageTintColor(UIColor.red, forState: .opened)
        menuView.setBackgroundColor(UIColor.yellow, forState: .closed)
        menuView.setBackgroundColor(UIColor.blue, forState: .opened)
        menuView.setOverlayColor(UIColor.green.withAlphaComponent(0.5), forState: .opened)
        menuView.animator = PrettyFloatingMenuRoundSlideAnimator()
    }
}

