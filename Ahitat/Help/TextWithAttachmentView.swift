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
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 20
        return NSMutableAttributedString(string: text, attributes: [.font: UIFont.proDisplayRegular,
                                                                            .foregroundColor: UIColor.slateTwo,
                                                                            .paragraphStyle: paragraphStyle])

    }

    private func getImageAsAttributed(image: String) -> NSAttributedString {
        let image1Attachment = NSTextAttachment()
        let image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        image1Attachment.image = image
        image1Attachment.bounds = CGRect(x: 0, y: -image.size.height/4, width: image.size.width, height: image.size.height)
        let attributed = NSAttributedString(attachment: image1Attachment)

        let mutable = NSMutableAttributedString(string: " ")
        mutable.append(attributed)

        mutable.addAttributes([.foregroundColor: UIColor.greyblue50,
                               .font: UIFont.proDisplayRegular],
                              range: NSRange(location: 0, length: mutable.length))
        return mutable
    }
 }

struct NSAttributable {
    var text: String
    var image: String
}
