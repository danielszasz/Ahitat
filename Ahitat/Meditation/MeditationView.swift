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
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var versesTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var authorTextView: UITextView!

    private var share: () -> Void = {}
    private var addToFavorites: (Bool) -> Void = {_ in}
    
    override func configureUI() {
        headerView.backgroundColor = .iceBlue
        headerView.layer.cornerRadius = 6
        
        headerTitleLabel.textColor = .slateTwo
        headerTitleLabel.font = UIFont.georgiaBoldItalic.changeSizeIfIpad
        
        dateLabel.textColor = .slateTwo
        dateLabel.font = UIFont.georgiaItalic.changeSizeIfIpad
        
        titleTextView.textColor = .slateTwo
        titleTextView.font = UIFont.proDisplaySemibold.changeSizeIfIpad
        titleTextView.textContainerInset = .zero
        
        contentTextView.textColor = .slateTwo
        contentTextView.font = UIFont.proDisplayRegular.changeSizeIfIpad
        contentTextView.textContainerInset = .zero
        
        authorTextView.textColor = .slateTwo
        authorTextView.font = UIFont.authorLabel.changeSizeIfIpad
        authorTextView.textContainerInset = .zero

        versesTextView.textContainerInset = .zero

        favoriteButton.setImage(UIImage(named: "iconFavorites0"), for: .normal)
        favoriteButton.setImage(UIImage(named: "iconFavorites1"), for: .selected)

        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        shareButton.isExclusiveTouch = true
    }
    
    func configure(headerTitle: String, date: Date, meditation: Meditation, isFavorite: Bool, share: @escaping @autoclosure () -> Void, addToFavorites: @escaping (Bool) -> Void) {

        headerTitleLabel.text = headerTitle
        dateLabel.text = date.longDate
        titleTextView.text = meditation.title
        versesTextView.attributedText = meditation.verse.getVersesAttributedText(boldedTexts: "Igehely", "Kulcsige")
        contentTextView.text = meditation.meditation.htmlToString
        authorTextView.text = meditation.author
        favoriteButton.isSelected = isFavorite

        self.share = share
        self.addToFavorites = addToFavorites
    }

    @objc private func shareButtonPressed() {
        share()
    }

    @IBAction func favoritePressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        addToFavorites(sender.isSelected)
    }
}
