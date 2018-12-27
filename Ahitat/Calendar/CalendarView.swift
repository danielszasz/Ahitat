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
    @IBOutlet private weak var calendarCollectionView: UICollectionView!
    @IBOutlet private weak var currentDayLabel: UILabel!

    private weak var delegate: CalendarViewDelegate?

    private var dates: [Date] = []
    private var selectedDate: Date = Date() {
        didSet {
            scroll(to: selectedDate)
            reloadView()
        }
    }

    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!

    override func configureUI() {
        backgroundColor = .black16

        leftButton.setImage(#imageLiteral(resourceName: "iconBackChevron.png"), for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont
        leftButton.setTitleColor(.slateTwo, for: .normal)
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)

        rightButton.setImage(#imageLiteral(resourceName: "iconForwardChevron.png"), for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont
        rightButton.semanticContentAttribute = .forceRightToLeft
        rightButton.setTitleColor(.slateTwo, for: .normal)
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

        currentDayLabel.textColor = .slate
        currentDayLabel.font = UIFont.georgiaItalic

        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        let nib = UINib.init(nibName: "DayCollectionViewCell", bundle: nil)
        calendarCollectionView.register(nib, forCellWithReuseIdentifier: "DayCollectionViewCell")
    }

    private func scroll(to date: Date) {
        calendarCollectionView.reloadData()

        guard let index = dates.firstIndex(where: { (element) -> Bool in
            return element.isSameDay(with: date)
        }) else {return}

        let indexPath = IndexPath(item: index, section: 0)
        calendarCollectionView.performBatchUpdates({
            self.calendarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

        }, completion: { _ in
        })
    }

    private func reloadView() {
        leftButton.setTitle(selectedDate.previousMonth, for: .normal)
        rightButton.setTitle(selectedDate.nextMonth, for: .normal)
        currentDayLabel.text = selectedDate.longDate
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
        cell.configure(date: model, isSelected: model.isSameDay(with: selectedDate))

        return cell
    }
}

extension CalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(date: dates[indexPath.item])
    }
}

extension CalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width/7
        let height: CGFloat = 65
        collectionViewHeightConstraint.constant = height
//        self.setNeedsLayout()
//        self.layoutIfNeeded()
        return CGSize(width: width, height: height)
    }
}
