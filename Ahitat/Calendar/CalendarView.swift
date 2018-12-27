//
//  CalendarView.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/26/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

class CalendarView: CustomView {

    @IBOutlet private weak var leftButton: AhitatButton!
    @IBOutlet private weak var rightButton: AhitatButton!
    @IBOutlet private weak var calendarCollectionView: UICollectionView!
    @IBOutlet private weak var currentDayLabel: UILabel!

    override func configureUI() {
        backgroundColor = .black16

        leftButton.setImage(#imageLiteral(resourceName: "iconBackChevron.png"), for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont
        leftButton.setTitleColor(.slateTwo, for: .normal)
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        leftButton.setTitle(Date().previousMonth, for: .normal)
        
        rightButton.setImage(#imageLiteral(resourceName: "iconForwardChevron.png"), for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont
        rightButton.semanticContentAttribute = .forceRightToLeft
        rightButton.setTitleColor(.slateTwo, for: .normal)
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        rightButton.setTitle(Date().nextMonth, for: .normal)

        currentDayLabel.textColor = .slate
        currentDayLabel.font = UIFont.georgiaItalic
        currentDayLabel.text = Date().longDate

    }
}

extension CalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension CalendarView: UICollectionViewDelegate {

}
