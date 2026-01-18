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
        dayLabel.font = UIFont.dayText.changeSizeIfIpad

        dayNumberLabel.textColor = .slate
        dayNumberLabel.font = UIFont.dayNumber.changeSizeIfIpad

        selectionBackground.backgroundColor = .greyblue50
        selectionBackground.isHidden = true
    }

    func configure(date: Date, isSelected: Bool, isPastToday: Bool) {
        dayLabel.text = date.daySymbol
        dayLabel.alpha = isPastToday ? 0.5 : 1
        dayLabel.textColor = date.isSunday ? .greenBlue : .slate

        dayNumberLabel.text = date.dayNumber
        dayNumberLabel.alpha = isPastToday ? 0.5 : 1

        // Update selection state
        if isSelected {
            configureForSelected()
        } else {
            configureForDeselected(isSunday: date.isSunday)
        }
        
        // Ensure corner radius is set after frame is available
        layoutIfNeeded()
        selectionBackground.layer.cornerRadius = selectionBackground.frame.width/2
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        selectionBackground.layer.cornerRadius = selectionBackground.frame.width/2
    }

    private func configureForSelected() {
        dayNumberLabel.textColor = .white
        dayNumberLabel.font = UIFont.systemMedium.changeSizeIfIpad
        selectionBackground.isHidden = false
    }

    private func configureForDeselected(isSunday: Bool) {
        dayNumberLabel.textColor = isSunday ? .greenBlue : .slate
        dayNumberLabel.font = UIFont.dayNumber.changeSizeIfIpad
        selectionBackground.isHidden = true
    }
}
