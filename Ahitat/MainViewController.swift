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
    @IBOutlet weak var meditationsStackView: UIStackView!

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
        addPanGestures()

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
        beforeNoonMeditation.configure(headerTitle: "Délelőtti Sorozat", date: meditation.date, meditation: meditation.beforeNoon)
        afternoonMeditation.configure(headerTitle: "Délutáni Sorozat", date: meditation.date, meditation: meditation.afterNoon)

        if meditation.bibliaora.isEmpty == false {
            let view = BibliaoraView()
            view.configure(with: meditation.bibliaora, boldText: "Bibliaóra")
            meditationsStackView.addArrangedSubview(view)
        } else {
            meditationsStackView.arrangedSubviews.forEach { (view) in
                guard view is BibliaoraView else {return}
                view.removeFromSuperview()
            }
        }

        if meditation.imaora.isEmpty == false {
            let view = BibliaoraView()
            view.configure(with: meditation.imaora, boldText: "Imaáhítat")
            meditationsStackView.addArrangedSubview(view)
        }
    }

    private func addNavBarButtons() {

        let hamburger = UIBarButtonItem(image: #imageLiteral(resourceName: "iconHamburgerMenu"), style: .plain, target: self, action: #selector(openSideMenu))
        self.navigationItem.leftBarButtonItems = [hamburger]

        let calendar = UIBarButtonItem(image: #imageLiteral(resourceName: "iconCalendar"), style: .plain, target: self, action: #selector(toggleCalendar))
        self.navigationItem.rightBarButtonItems = [calendar]
    }

    private func addPanGestures() {
        let leftPan = UISwipeGestureRecognizer(target: self, action: #selector(nextDay))
        leftPan.direction = .left
        meditationsStackView.addGestureRecognizer(leftPan)

        let rightPan = UISwipeGestureRecognizer(target: self, action: #selector(previousDay))
        rightPan.direction = .right
        meditationsStackView.addGestureRecognizer(rightPan)
    }

    @objc private func openSideMenu() {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }

    @objc private func nextDay() {
        guard meditations.last != currentMeditaion else {return}
        let dayInSeconds: TimeInterval = 3600 * 24
        didSelect(date: (currentMeditaion?.date ?? Date()).addingTimeInterval(dayInSeconds))
    }

    @objc private func previousDay() {
        guard meditations.first != currentMeditaion else {return}
        let dayInSeconds: TimeInterval = 3600 * 24
        didSelect(date: (currentMeditaion?.date ?? Date()).addingTimeInterval(-dayInSeconds))
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
