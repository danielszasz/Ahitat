//
//  FavoritesTableViewCell.swift
//  Ahitat
//
//  Created by Daniel Szasz on 1/4/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.authorLabel.changeSizeIfIpad
        titleLabel.textColor = .slateTwo

        dateLabel.font = UIFont.georgiaItalic.changeSizeIfIpad
        dateLabel.textColor = .slateTwo
    }

    func configure(model: FavoriteModel) {
        titleLabel.text = model.title
        dateLabel.text = model.date.longDate
    }
}
