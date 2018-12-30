    //
//  BibliaoraView.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/29/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

class BibliaoraView: CustomView {

    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var contentLabel: UILabel!

    override func configureUI() {
        backgroundView.layer.cornerRadius = 5
        backgroundView.backgroundColor = .iceBlue
    }

    func configure(with text: String, boldText: String) {
        contentLabel.attributedText = text.getVersesAttributedText(boldedTexts: boldText)
    }
}
