//
//  CalendarView.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/26/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

protocol CalendarViewDelegate: class {
    func didSelect(date: Date)
}

class CalendarView: CustomView {

    @IBOutlet private weak var leftButton: AhitatButton!
    @IBOutlet private weak var rightButton: AhitatButton!
    @IBOutlet private weak var currentMonthLabel: UILabel!
    @IBOutlet private weak var calendarCollectionView: UICollectionView!
    @IBOutlet private weak var currentDayLabel: UILabel!
    @IBOutlet private weak var currentDayContainerView: UIView!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var todayLabel: UILabel!
    @IBOutlet private weak var todayContainerView: UIView!

    private weak var delegate: CalendarViewDelegate?

    private var dates: [Date] = []
    private var manuallySelectingDate: Bool = false

    private var selectedDate: Date = Date() {
        didSet {
            reloadView()
            scroll(to: selectedDate)
        }
    }

    override func configureUI() {
        backgroundColor = .black16

        leftButton.setImage(#imageLiteral(resourceName: "iconBackChevron.png"), for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFontLight.changeSizeIfIpad
        leftButton.setTitleColor(.slateTwo, for: .normal)
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        leftButton.addTarget(self, action: #selector(goToPreviousMonth), for: .touchUpInside)

        rightButton.setImage(#imageLiteral(resourceName: "iconForwardChevron.png"), for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFontLight.changeSizeIfIpad
        rightButton.semanticContentAttribute = .forceRightToLeft
        rightButton.setTitleColor(.slateTwo, for: .normal)
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        rightButton.addTarget(self, action: #selector(goToNextMonth), for: .touchUpInside)

        currentMonthLabel.textColor = UIColor.slate
        currentMonthLabel.font = UIFont.systemFontSemibold.changeSizeIfIpad

        currentDayLabel.textColor = .slate
        currentDayLabel.font = UIFont.georgiaItalic.changeSizeIfIpad
        currentDayContainerView.backgroundColor = .iceBlue

        configureToday()

        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self

        let nib = UINib.init(nibName: "DayCollectionViewCell", bundle: nil)
        calendarCollectionView.register(nib, forCellWithReuseIdentifier: "DayCollectionViewCell")
    }

    private func configureToday() {
        todayLabel.textColor = .slate
        todayLabel.font = UIFont.systemFontSemibold.withSize(12).changeSizeIfIpad
        todayLabel.text = "Mai Áhitat"
        todayContainerView.backgroundColor = .greyblue50
        let tap = UITapGestureRecognizer(target: self, action: #selector(returnToToday))
        todayContainerView.addGestureRecognizer(tap)
    }

    @objc private func returnToToday() {
        delegate?.didSelect(date: Date())
    }

    private func scroll(to date: Date) {
        guard let index = dates.firstIndex(where: { (element) -> Bool in
            return element.isSameDay(with: date)
        }) else {return}

        let indexPath = IndexPath(item: index, section: 0)
        calendarCollectionView.performBatchUpdates({
            calendarCollectionView.reloadSections(IndexSet(integer: 0))
        }, completion: { _ in
            self.calendarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        })
    }

    private func reloadView() {
        reloadMonths(with: selectedDate)
        currentDayLabel.text = selectedDate.longDate
        currentMonthLabel.text = selectedDate.currentMonth
        manuallySelectingDate = true
    }

    @objc private func goToPreviousMonth() {
        delegate?.didSelect(date: selectedDate.previousMonth)
    }

    @objc private func goToNextMonth() {
        delegate?.didSelect(date: selectedDate.nextMonth)
    }

    private func reloadMonths(with date: Date) {
        guard let firstDate = dates.first,
            let lastDate = dates.last else {return}

        rightButton.isHidden = lastDate.isSameMonth(with: date)
        leftButton.isHidden = firstDate.isSameMonth(with: date)
        leftButton.setTitle(date.previousMonthString, for: .normal)
        rightButton.setTitle(date.nextMonthString, for: .normal)
        currentMonthLabel.text = date.currentMonth
    }

    func configure(dates: [Date], delegate: CalendarViewDelegate) {
        self.dates = dates
        self.delegate = delegate
        self.calendarCollectionView.reloadData()
    }

    func select(date: Date) {
        selectedDate = date
    }
}

extension CalendarView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionViewCell", for: indexPath) as! DayCollectionViewCell
        let model = dates[indexPath.item]
        cell.configure(date: model, isSelected: model.isSameDay(with: selectedDate), isPastToday: model > Date())

        return cell
    }
}

extension CalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(date: dates[indexPath.item])
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        manuallySelectingDate = false
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard manuallySelectingDate == false else {return}
        let visibleCellsIndexPath = collectionView.indexPathsForVisibleItems
        let firstIndex = visibleCellsIndexPath.first?.item ?? 0
        let lastIndex = visibleCellsIndexPath.last?.item ?? 0
        let firstElement = dates[firstIndex]
        let lastElement = dates[lastIndex]
        if firstElement.isSameMonth(with: lastElement) {
            reloadMonths(with: firstElement)
        }
    }
}

extension CalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let daysInARow: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 13 : 7
        let width = UIScreen.main.bounds.width/daysInARow
        let height: CGFloat = 68
        collectionViewHeightConstraint.constant = height
        return CGSize(width: width, height: height)
    }
}
