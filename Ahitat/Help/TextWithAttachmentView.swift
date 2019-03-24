//
//  TextWithAttachmentView.swift
//  Ahitat
//
//  Created by Daniel Szasz on 3/24/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import UIKit

class TextWithAttachmentView: CustomView {

    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!

    override func configureUI() {
        super.configureUI()
        separatorView.backgroundColor = .paleBlue
    }

    func configure(elements: [NSAttributable]) {
        let fullString = NSMutableAttributedString()
        elements.forEach { (element) in
            if !element.text.isEmpty {
                fullString.append(getTextAsAttributed(text: element.text))
            } else {
                fullString.append(getImageAsAttributed(image: element.image))
            }
        }
        textLabel.attributedText = fullString
    }

    private func getTextAsAttributed(text: String) -> NSAttributedString {
        return NSMutableAttributedString(string: text, attributes: [.font: UIFont.authorLabel,
                                                                            .foregroundColor: UIColor.slateTwo])

    }

    private func getImageAsAttributed(image: String) -> NSAttributedString {
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: image)

        return NSAttributedString(attachment: image1Attachment)
    }
 }

struct NSAttributable {
    var text: String
    var image: String
}
