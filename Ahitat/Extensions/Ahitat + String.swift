//
//  Ahitat + String.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/29/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

    func getVersesAttributedText(boldedTexts: String...) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.5
        let attributed = NSMutableAttributedString(string: self, attributes: [.foregroundColor: UIColor.slateTwo,
                                                                              .font: UIFont.georgiaItalic,
                                                                              NSAttributedString.Key.paragraphStyle: paragraphStyle])

        boldedTexts.forEach { (textToBold) in
            let range = (self as NSString).range(of: textToBold)
            attributed.addAttributes([.font: UIFont.proDisplaySemiboldItalic], range: range)
        }

        return attributed
    }
}
