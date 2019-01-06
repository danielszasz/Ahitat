//
//  DayCollectionViewCell.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/27/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var selectionBackground: UIView!
    @IBOutlet private weak var dayNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        dayLabel.textColor = .slate
        dayLabel.font = UIFont.dayText

        dayNumberLabel.textColor = .slate
        dayNumberLabel.font = UIFont.dayNumber

        selectionBackground.backgroundColor = .greyblue50
        selectionBackground.isHidden = true
    }

    func configure(date: Date, isSelected: Bool, isPastToday: Bool) {
        dayLabel.text = date.daySymbol
        dayLabel.alpha = isPastToday ? 0.5 : 1
        dayLabel.textColor = date.isSunday ? .greenBlue : .slate

        dayNumberLabel.text = date.dayNumber
        dayNumberLabel.alpha = isPastToday ? 0.5 : 1

        selectionBackground.layer.cornerRadius = selectionBackground.frame.width/2
        _ = isSelected
            ? configureForSelected()
            : configureForDeselected(isSunday: date.isSunday)
    }

    private func configureForSelected() {
        dayNumberLabel.textColor = .white
        dayNumberLabel.font = UIFont.systemMedium
        selectionBackground.isHidden = false
    }

    private func configureForDeselected(isSunday: Bool) {
        dayNumberLabel.textColor = isSunday ? .greenBlue : .slate
        dayNumberLabel.font = UIFont.dayNumber
        selectionBackground.isHidden = true
    }
}
