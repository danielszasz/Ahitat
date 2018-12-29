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
    @IBOutlet private weak var calendarView: CalendarView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet weak var beforeNoonMeditation: MeditationView!
    @IBOutlet weak var afternoonMeditation: MeditationView!
    
    private var meditations: [DailyMeditation] = []
    private var currentMeditaion: DailyMeditation? {
        didSet {
            guard let med = currentMeditaion else {return}
            calendarView.select(date: med.date)
            setMeditationViews(with: med)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendarView.backgroundColor = .black16
        stackView.alpha = 0
        calendarView.isHidden = true

        configureSideMenu()
        addNavBarButtons()

        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bgHeader"), for: .topAttached, barMetrics: .default)
        self.navigationController?.navigationBar.tintColor = .white

        meditations = DatabaseHandler().getMeditations()
        calendarView.configure(dates: meditations.map({$0.date}), delegate: self)
        didSelect(date: Date())
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

    private func setMeditationViews(with meditation: DailyMeditation) {
        beforeNoonMeditation.configure(headerTitle: "Delelotti sorozat", date: meditation.date, meditation: meditation.beforeNoon)
        afternoonMeditation.configure(headerTitle: "Delutani sorozat", date: meditation.date, meditation: meditation.afterNoon)

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
        //when appearing we need it before animation
        if calendarView.isHidden {
            self.hideCalendarViewAnimated(false)
        }
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCurlUp, animations: {
            self.stackView.alpha = self.stackView.alpha == 0 ? 1 : 0
        }, completion: { _ in
            guard self.stackView.alpha == 0 else {return}
            self.hideCalendarViewAnimated(true)
        })
    }

    private func hideCalendarViewAnimated(_ value: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            self.calendarView.isHidden = value
        })
    }
}

extension MainViewController: CalendarViewDelegate {
    func didSelect(date: Date) {
        print(#function)
        currentMeditaion = meditations.filter({$0.date.isSameDay(with: date)}).first
    }
}
