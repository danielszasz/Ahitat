//
//  MainViewController.swift
//  Ahitat
//
//  Created by Daniel Szasz on 9/14/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit
import SideMenu

protocol MainDelegate: class {
    func openMeditation(with date: Date, isAfterNoon: Bool)
}

class MainViewController: UIViewController {
    @IBOutlet private weak var calendarView: CalendarView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var beforeNoonMeditation: MeditationView!
    @IBOutlet private weak var afternoonMeditation: MeditationView!
    @IBOutlet private weak var meditationsStackView: UIStackView!
    @IBOutlet private weak var scrollView: UIScrollView!

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
        configureNavigationBar()

        meditations = DatabaseHandler().getMeditations()
        calendarView.configure(dates: meditations.map({$0.date}), delegate: self)
        calendarView.addShadow()
        didSelect(date: Date())
    }

    private func configureSideMenu() {
        // Define the menus
        let vc = MenuViewController(delegate: self)
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: vc)

        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth = UIScreen.main.bounds.width * 0.56
        SideMenuManager.default.menuAnimationFadeStrength = 0.4
    }

    private func configureNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bgHeader"), for: .topAttached, barMetrics: .default)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Napi Áhitatok"
    }

    private func setMeditationViews(with meditation: DailyMeditation) {
        beforeNoonMeditation.configure(headerTitle: "Délelőtti Sorozat", date: meditation.date, meditation: meditation.beforeNoon, share: self.share(meditation: self.currentMeditaion?.beforeNoon))
        afternoonMeditation.configure(headerTitle: "Délutáni Sorozat", date: meditation.date, meditation: meditation.afterNoon, share: self.share(meditation: self.currentMeditaion?.afterNoon))

        if meditation.bibliaora.isEmpty == false {
            let view = BibliaoraView()
            view.configure(with: meditation.bibliaora, boldText: "Bibliaóra")
            meditationsStackView.insertArrangedSubview(view, at: 1)
        } else {
            meditationsStackView.arrangedSubviews.forEach { (view) in
                guard view is BibliaoraView else {return}
                view.removeFromSuperview()
            }
        }

        if meditation.imaora.isEmpty == false {
            let view = BibliaoraView()
            view.configure(with: meditation.imaora, boldText: "Imaáhítat")
            meditationsStackView.insertArrangedSubview(view, at: 2)
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

    private func share(meditation: Meditation?) {
        guard let meditation = meditation else {return}
        let appActivities = [AddToFavorites()]
        let controller = UIActivityViewController(activityItems: [meditation.meditation], applicationActivities: appActivities)
        controller.popoverPresentationController?.sourceView = self.view
        controller.popoverPresentationController?.sourceRect = self.view.frame

        controller.completionWithItemsHandler = { [weak self] type, completed, _, error in
            guard type?.rawValue == "addToFavorites" else {return}
            self?.addToFavorites(meditation)
        }
        self.navigationController?.present(controller, animated: true, completion: nil)
    }

    private func addToFavorites(_ meditation: Meditation) {
        guard let currentMeditation = currentMeditaion else {return}
        let model = FavoriteModel.init(author: meditation.author, date: currentMeditation.date, title: meditation.title, isAfternoon: meditation == currentMeditation.afterNoon)
        AhitatUserDefaults().add(model: model)
    }
}

extension MainViewController: CalendarViewDelegate {
    func didSelect(date: Date) {
        print(#function)
        currentMeditaion = meditations.filter({$0.date.isSameDay(with: date)}).first
    }
}

extension MainViewController: MainDelegate {
    func openMeditation(with date: Date, isAfterNoon: Bool) {
        didSelect(date: date)
        guard let viewToSrollTo = isAfterNoon ? afternoonMeditation : beforeNoonMeditation else {return}

        scrollView.scrollToView(view: viewToSrollTo, animated: true)
    }
}
