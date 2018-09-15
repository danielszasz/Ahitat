//
//  MainViewController.swift
//  Ahitat
//
//  Created by Daniel Szasz on 9/14/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit
import SideMenu

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSideMenu()
        addNavBarButtons()

        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bgHeader"), for: .topAttached, barMetrics: .default)
        self.navigationController?.navigationBar.tintColor = .white
    }

    private func configureSideMenu() {
        // Define the menus
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: MenuViewController())

        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth = UIScreen.main.bounds.width * 0.70
        SideMenuManager.default.menuAnimationFadeStrength = 0.4
    }

    private func addNavBarButtons() {

        let hamburger = UIBarButtonItem(image: #imageLiteral(resourceName: "iconHamburgerMenu"), style: .plain, target: self, action: #selector(openSideMenu))
        self.navigationItem.leftBarButtonItems = [hamburger]

        let calendar = UIBarButtonItem(image: #imageLiteral(resourceName: "iconCalendar"), style: .plain, target: self, action: #selector(toggleCalendar))
        self.navigationItem.rightBarButtonItems = [calendar]
    }

    @objc private func openSideMenu() {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
    }

    @objc private func toggleCalendar() {

    }
}
