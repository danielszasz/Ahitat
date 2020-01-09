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
        addLink(textView: versesTextView)

        contentTextView.text = meditation.meditation.htmlToString
        addLink(textView: contentTextView)

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

    private func addLink(textView: UITextView) {
        let sstring = textView.attributedText.string
        let regex = try? NSRegularExpression(pattern: "[a-záéúőóüöA-Z1-9]+\\s+\\d{1,3}:+\\s?+\\d{1,3}(-\\d{1,3})?", options: .caseInsensitive)

        guard let fs = regex?.matches(in: sstring, options: .reportCompletion,
                                      range: NSRange(location: 0, length: sstring.count)) else {return}
        for result in fs {
            let string = (sstring as NSString).substring(with: result.range)
            let components = string.components(separatedBy: [":", " ", "-"])

            let book = components[0]
            let chapter = components[1]
            let verse = components[2]

            guard let attributed = textView.attributedText else {return}

            let mutable = NSMutableAttributedString(attributedString: attributed)
            let link = LinkConstructor().getLink(book: book,
                                                 chapter: chapter,
                                                 firstVerse: verse)
            guard let url = URL(string: link) else {return}

            mutable.addAttributes([.link: url], range: result.range)
            textView.attributedText = mutable
            textView.isUserInteractionEnabled = true
            textView.delegate = self
            textView.linkTextAttributes = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        }
    }
}

extension MeditationView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        guard UIApplication.shared.canOpenURL(URL) else {return false}
        UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        return true
    }
}
