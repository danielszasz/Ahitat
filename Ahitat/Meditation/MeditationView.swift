//
//  MeditationView.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/28/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

class MeditationView: CustomView {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var versesLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    private var share: () -> Void = {}
    
    override func configureUI() {
        headerView.backgroundColor = .iceBlue
        headerView.layer.cornerRadius = 6
        
        headerTitleLabel.textColor = .slateTwo
        headerTitleLabel.font = UIFont.georgiaBoldItalic.changeSizeIfIpad
        
        dateLabel.textColor = .slateTwo
        dateLabel.font = UIFont.georgiaItalic.changeSizeIfIpad
        
        titleLabel.textColor = .slateTwo
        titleLabel.font = UIFont.proDisplaySemibold.changeSizeIfIpad
        
        contentLabel.textColor = .slateTwo
        contentLabel.font = UIFont.proDisplayRegular.changeSizeIfIpad
        
        authorLabel.textColor = .slateTwo
        authorLabel.font = UIFont.authorLabel.changeSizeIfIpad

        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        shareButton.isExclusiveTouch = true
    }
    
    func configure(headerTitle: String, date: Date, meditation: Meditation, share: @escaping @autoclosure () -> Void) {
        headerTitleLabel.text = headerTitle
        dateLabel.text = date.longDate
        titleLabel.text = meditation.title
        versesLabel.attributedText = meditation.verse.getVersesAttributedText(boldedTexts: "Igehely", "Kulcsige")
        contentLabel.text = meditation.meditation.htmlToString
        authorLabel.text = meditation.author
        self.share = share
    }

    @objc private func shareButtonPressed() {
        share()
    }
}
