//
//  MenuTableViewCell.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/31/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = .slateTwo
        titleLabel.font = UIFont.proDisplayRegular.changeSizeIfIpad
    }

    func configure(with model: ViewModel) {
        iconImageView.image = model.image
        titleLabel.text = model.title
    }
}

extension MenuTableViewCell {
    struct ViewModel {
        let image: UIImage
        let title: String
    }
}
