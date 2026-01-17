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
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var versesTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var authorTextView: UITextView!

    private var share: () -> Void = {}
    private var addToFavorites: (Bool) -> Void = {_ in}
    private var onPlayPressed: (Date, Meditation) -> Bool = { _, _ in false }
    
    private var currentMeditation: Meditation?
    private var currentDate: Date?
    private var progressLayer: CAShapeLayer?
    
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

        // Configure favorite button with SF Symbols
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: [.selected, .highlighted])
        favoriteButton.tintColor = .greyblue50
        favoriteButton.imageEdgeInsets = .zero
        favoriteButton.contentEdgeInsets = .zero
        favoriteButton.adjustsImageWhenHighlighted = false
        favoriteButton.showsTouchWhenHighlighted = false
        
        // Configure play button with SF Symbols
        playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        playButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .selected)
        playButton.setImage(UIImage(systemName: "pause.circle.fill"), for: [.selected, .highlighted])
        playButton.tintColor = .greyblue50
        playButton.imageEdgeInsets = .zero
        playButton.contentEdgeInsets = .zero
        playButton.isExclusiveTouch = true
        playButton.adjustsImageWhenHighlighted = false
        playButton.showsTouchWhenHighlighted = false
        playButton.isHidden = true // Hidden by default until file check

        // Configure share button with SF Symbols
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .greyblue50
        shareButton.imageEdgeInsets = .zero
        shareButton.contentEdgeInsets = .zero
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        shareButton.isExclusiveTouch = true
        shareButton.adjustsImageWhenHighlighted = false
        shareButton.showsTouchWhenHighlighted = false
        
        setupProgressBorder()
    }
    
    private func setupProgressBorder() {
        // Remove existing layer if any
        progressLayer?.removeFromSuperlayer()
        
        // Ensure headerView clips to bounds with rounded corners
        headerView.clipsToBounds = true
        
        // Create shape layer that fills from left to right with darker overlay
        let layer = CAShapeLayer()
        layer.frame = headerView.bounds
        layer.backgroundColor = UIColor.black.withAlphaComponent(0.15).cgColor
        
        // Start with zero width
        layer.frame.size.width = 0
        
        // Add to header view at the back
        headerView.layer.insertSublayer(layer, at: 0)
        progressLayer = layer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update progress layer frame when view bounds change
        if let progressLayer = progressLayer {
            let currentProgress = progressLayer.frame.width / progressLayer.frame.height > 0 
                ? progressLayer.frame.width / headerView.bounds.width 
                : 0
            progressLayer.frame = CGRect(
                x: 0,
                y: 0,
                width: headerView.bounds.width * currentProgress,
                height: headerView.bounds.height
            )
        }
    }
    
    func configure(headerTitle: String, date: Date, meditation: Meditation, isFavorite: Bool, share: @escaping @autoclosure () -> Void, addToFavorites: @escaping (Bool) -> Void, onPlayPressed: @escaping (Date, Meditation) -> Bool) {

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
        self.onPlayPressed = onPlayPressed
        self.currentMeditation = meditation
        self.currentDate = date
        
        // Reset play button state
        playButton.isSelected = false
    }

    @objc private func shareButtonPressed() {
        share()
    }

    @IBAction func favoritePressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        addToFavorites(sender.isSelected)
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        guard let meditation = currentMeditation,
              let date = currentDate else {
            return
        }
        
        sender.isSelected = onPlayPressed(date, meditation)
    }
    
    // MARK: - Audio Control
    
    func setPlayButtonVisibility(_ visible: Bool) {
        playButton.isHidden = !visible
    }
    
    func stopAudio() {
        playButton.isSelected = false
        resetProgress()
    }
    
    func updateProgress(_ progress: Double) {
        guard let progressLayer = progressLayer else { return }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.frame.size.width = headerView.bounds.width * CGFloat(progress)
        CATransaction.commit()
    }
    
    func resetProgress() {
        guard let progressLayer = progressLayer else { return }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.frame.size.width = 0
        CATransaction.commit()
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
