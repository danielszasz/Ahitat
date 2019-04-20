//
//  WeMadeThisView.swift
//  Ahitat
//
//  Created by Daniel Szasz on 4/12/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import UIKit

class WeMadeThisView: CustomView {

    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var szaszNameLabel: UILabel!
    @IBOutlet private weak var szaszLocationLabel: UILabel!
    @IBOutlet private weak var szaszJobLabel: UILabel!

    @IBOutlet private weak var szucsNameLabel: UILabel!
    @IBOutlet private weak var szucsLocationLabel: UILabel!
    @IBOutlet private weak var szucsJobLabel: UILabel!

    @IBOutlet private weak var photoOriginLabel: UILabel!

    override func configureUI() {
        super.configureUI()

        titleLabel.text = "A készítőkről"
        titleLabel.font = UIFont.authorLabel.changeSizeIfIpad
        titleLabel.textColor = .slateTwo

        szaszNameLabel.text = "Szász Dániel"
        szaszNameLabel.font = UIFont.authorLabel.changeSizeIfIpad
        szaszNameLabel.textColor = .slateTwo

        szucsNameLabel.text = "Szűcs Árpád"
        szucsNameLabel.font = UIFont.authorLabel.changeSizeIfIpad
        szucsNameLabel.textColor = .slateTwo

        szaszLocationLabel.text = "(Nagyvárad - szasz.daniel@yahoo.com)"
        szaszLocationLabel.font = UIFont.sponsorFont.changeSizeIfIpad
        szaszLocationLabel.textColor = .slateTwo

        szucsLocationLabel.text = "(Kraszna - arpad.szucs@gmail.com)"
        szucsLocationLabel.font = UIFont.sponsorFont.changeSizeIfIpad
        szucsLocationLabel.textColor = .slateTwo

        szaszJobLabel.text = "- adminisztratív feladatok\n- iOS fejlesztés"
        szaszJobLabel.font = UIFont.proDisplayRegular.changeSizeIfIpad
        szaszJobLabel.textColor = .slateTwo

        szucsJobLabel.text = "- felhasználói felület dizájn\n- app icon dizájn\n- leírások"
        szucsJobLabel.font = UIFont.proDisplayRegular.changeSizeIfIpad
        szucsJobLabel.textColor = .slateTwo

        let attributedString = NSMutableAttributedString(string: "Fotó - Unsplash (Maxime Gauthier)", attributes: [
            .font: UIFont.systemFont(ofSize: 14.0, weight: .regular).changeSizeIfIpad,
            .foregroundColor: UIColor.slateTwo
            ])
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16.0, weight: .semibold).changeSizeIfIpad, range: NSRange(location: 0, length: 4))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16.0, weight: .regular).changeSizeIfIpad, range: NSRange(location: 4, length: 12))

        photoOriginLabel.attributedText = attributedString
    }
}
