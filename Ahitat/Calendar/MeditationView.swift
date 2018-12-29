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
    
    override func configureUI() {
        headerView.backgroundColor = .iceBlue
        headerView.layer.cornerRadius = 6
        
        headerTitleLabel.textColor = .slateTwo
        headerTitleLabel.font = UIFont.georgiaBoldItalic
        
        dateLabel.textColor = .slateTwo
        dateLabel.font = UIFont.georgiaItalic
        
        titleLabel.textColor = .slateTwo
        titleLabel.font = UIFont.proDisplaySemibold
        
        contentLabel.textColor = .slateTwo
        contentLabel.font = UIFont.proDisplayRegular
        
        authorLabel.textColor = .slateTwo
        authorLabel.font = UIFont.authorLabel
    }
    
    func configure(headerTitle: String, date: Date, meditation: Meditation) {
        headerTitleLabel.text = headerTitle
        dateLabel.text = date.longDate
        titleLabel.text = meditation.title
        versesLabel.attributedText = meditation.verse.getVersesAttributedText(boldedTexts: "Igehely", "Kulcsige")
        contentLabel.text = meditation.meditation.htmlToString
        authorLabel.text = meditation.author
    }

}
