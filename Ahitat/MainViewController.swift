//
//  MainViewController.swift
//  Ahitat
//
//  Created by Daniel Szasz on 9/14/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit
import SideMenu

protocol MainDelegate: AnyObject {
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
    private let audioPlayer = AudioPlayerManager.shared
    private let audioBaseURL = "https://ahitat.rmbgysz.ro/hangosahitat"
    private var currentPlayingView: MeditationView?
    
    private var currentMeditation: DailyMeditation? {
        didSet {
            guard let med = currentMeditation else {return}
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
        setupAudioPlayerCallbacks()

        meditations = DatabaseHandler().getMeditations()
        calendarView.configure(dates: meditations.map({$0.date}), delegate: self)
        calendarView.addShadow()
        didSelect(date: Date())
    }

    private func configureSideMenu() {
        // Define the menus
        let vc = MenuViewController(delegate: self)
        let menuLeftNavigationController = SideMenuNavigationController(rootViewController: vc)

        menuLeftNavigationController.menuWidth = UIScreen.main.bounds.width * 0.56
        menuLeftNavigationController.presentationStyle = .menuSlideIn
        menuLeftNavigationController.statusBarEndAlpha = 0
        menuLeftNavigationController.presentationStyle.presentingEndAlpha = 0.4

        SideMenuManager.default.leftMenuNavigationController = menuLeftNavigationController
    }

    private func configureNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bgHeader"), for: .topAttached, barMetrics: .default)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Napi Áhitatok"
    }

    private func setMeditationViews(with meditation: DailyMeditation) {
        guard let meditation = currentMeditation else {return}
        let isBeforeFavorite = AhitatUserDefaults().isFavorite(with: meditation.id, isAfterNoon: false)

        beforeNoonMeditation.configure(headerTitle: "Délelőtti Sorozat", date: meditation.date,
                                       meditation: meditation.beforeNoon, isFavorite: isBeforeFavorite,
                                       share: self.share(meditation: self.currentMeditation?.beforeNoon),
                                       addToFavorites: favoritePressed(meditation: meditation.beforeNoon),
                                       onPlayPressed: handlePlayPressed(view: beforeNoonMeditation, isAfterNoon: false))

        let isAfterFavorite = AhitatUserDefaults().isFavorite(with: meditation.id, isAfterNoon: true)

        afternoonMeditation.configure(headerTitle: "Délutáni Sorozat", date: meditation.date,
                                      meditation: meditation.afterNoon, isFavorite: isAfterFavorite,
                                      share: self.share(meditation: self.currentMeditation?.afterNoon),
                                      addToFavorites: favoritePressed(meditation: meditation.afterNoon),
                                      onPlayPressed: handlePlayPressed(view: afternoonMeditation, isAfterNoon: true))

        // Check audio file availability
        checkAudioAvailability(for: meditation.date, isAfterNoon: false) { [weak self] exists in
            self?.beforeNoonMeditation.setPlayButtonVisibility(exists)
        }
        
        checkAudioAvailability(for: meditation.date, isAfterNoon: true) { [weak self] exists in
            self?.afternoonMeditation.setPlayButtonVisibility(exists)
        }

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
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }

    @objc private func nextDay() {
        guard meditations.last != currentMeditation else {return}
        let dayInSeconds: TimeInterval = 3600 * 24
        didSelect(date: (currentMeditation?.date ?? Date()).addingTimeInterval(dayInSeconds))
    }

    @objc private func previousDay() {
        guard meditations.first != currentMeditation else {return}
        let dayInSeconds: TimeInterval = 3600 * 24
        didSelect(date: (currentMeditation?.date ?? Date()).addingTimeInterval(-dayInSeconds))
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
        let fullText = [meditation.title, meditation.verse, meditation.meditation, meditation.author].joined(separator: "\n\n")
        let controller = UIActivityViewController(activityItems: [fullText], applicationActivities: nil)
        controller.popoverPresentationController?.sourceView = self.view
        controller.popoverPresentationController?.sourceRect = self.view.frame

        self.navigationController?.present(controller, animated: true, completion: nil)
    }

    private func favoritePressed(meditation: Meditation) -> (Bool) -> Void {
        return { [weak self] add in

            guard let currentMeditation = self?.currentMeditation else {return}
            
            let model = FavoriteModel.init(id: currentMeditation.id, author: meditation.author, date: currentMeditation.date, title: meditation.title, isAfternoon: meditation == currentMeditation.afterNoon)

            _ = add
                ? AhitatUserDefaults().add(model: model)
                : AhitatUserDefaults().delete(model: model)
        }
    }
    
    // MARK: - Audio Handling
    
    private func setupAudioPlayerCallbacks() {
        audioPlayer.onPlaybackFinished = { [weak self] in
            // Reset both meditation views when playback finishes
            self?.beforeNoonMeditation.stopAudio()
            self?.afternoonMeditation.stopAudio()
            self?.currentPlayingView = nil
        }
        
        audioPlayer.onProgressUpdate = { [weak self] progress in
            // Update progress on the currently playing view
            self?.currentPlayingView?.updateProgress(progress)
        }
    }
    
    private func handlePlayPressed(view: MeditationView, isAfterNoon: Bool) -> (Date, Meditation) -> Bool {
        return { [weak self] date, meditation in
            guard let self = self else { return false }
            
            // If another meditation is playing, stop it first
            if let currentPlayingView = self.currentPlayingView, currentPlayingView != view {
                currentPlayingView.stopAudio()
                self.audioPlayer.stop()
            }
            
            // Generate audio URL based on date
            let audioUrl = self.generateAudioURL(for: date, isAfterNoon: isAfterNoon)
            
            // Toggle play/pause
            let isPlaying = self.audioPlayer.togglePlayPause(
                urlString: audioUrl,
                title: meditation.title,
                artist: meditation.author
            )
            
            // Update current playing view
            self.currentPlayingView = isPlaying ? view : nil
            
            return isPlaying
        }
    }
    
    private func generateAudioURL(for date: Date, isAfterNoon: Bool) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        let suffix = isAfterNoon ? "du" : "de"
        return "\(audioBaseURL)/\(dateString)_\(suffix).mp3"
    }
    
    private func checkAudioAvailability(for date: Date, isAfterNoon: Bool, completion: @escaping (Bool) -> Void) {
        let audioUrl = generateAudioURL(for: date, isAfterNoon: isAfterNoon)
        
        guard let url = URL(string: audioUrl) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        request.timeoutInterval = 5.0
        
        let task = URLSession.shared.dataTask(with: request) { _, response, _ in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    completion(httpResponse.statusCode == 200)
                } else {
                    completion(false)
                }
            }
        }
        task.resume()
    }
}

extension MainViewController: CalendarViewDelegate {
    func didSelect(date: Date) {
        let currentMeditation = meditations.filter({$0.date.isSameDay(with: date)}).first ?? meditations.last

        if currentMeditation != self.currentMeditation {
            print(#function)
            
            // Stop audio and reset progress when changing meditation
            audioPlayer.stop()
            beforeNoonMeditation.stopAudio()
            afternoonMeditation.stopAudio()
            currentPlayingView = nil
            
            self.currentMeditation = currentMeditation
        }
    }
}

extension MainViewController: MainDelegate {
    func openMeditation(with date: Date, isAfterNoon: Bool) {
        didSelect(date: date)
        guard let viewToSrollTo = isAfterNoon ? afternoonMeditation : beforeNoonMeditation else {return}

        scrollView.scrollToView(view: viewToSrollTo, animated: true)
    }
}
