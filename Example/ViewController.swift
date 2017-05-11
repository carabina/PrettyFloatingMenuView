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

    // MARK: - Private Instance Methods
    private func prepareMenuView() {
        let firstItem = PrettyFloatingMenuItem()
        firstItem.attributedTitle = NSAttributedString(string: "Test Item 1")
        firstItem.iconImage = UIImage(named: "community-icon")

        let secondItem = PrettyFloatingMenuItem()
        secondItem.attributedTitle = NSAttributedString(string: "Test Item 2")
        secondItem.iconImage = UIImage(named: "trophy-icon")
        
        let thirdItem = PrettyFloatingMenuItem()
        thirdItem.attributedTitle = NSAttributedString(string: "Test Item 3")
        thirdItem.iconImage = UIImage(named: "alert-icon")
        
        menuView.items = [firstItem, secondItem, thirdItem]
    }
}

