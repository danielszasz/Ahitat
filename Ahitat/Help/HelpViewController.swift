//
//  HelpViewController.swift
//  Ahitat
//
//  Created by Daniel Szasz on 3/23/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var sponsorLabel: UILabel!
    @IBOutlet private weak var copyrightLabel: UILabel!
    @IBOutlet private weak var versionLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!

    private var texts = HelpScreenTexts()
    private var sections: [ExpandableSection] = [ChoosingMeditationTexts()]

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = UIFont.proDisplaySemibold
        titleLabel.textColor = .slateTwo
        titleLabel.text = texts.title

        descriptionLabel.font = UIFont.proDisplayRegular
        descriptionLabel.textColor = .slateTwo
        descriptionLabel.text = texts.description

        sponsorLabel.font = UIFont.sponsorFont
        sponsorLabel.textColor = .slateTwo
        sponsorLabel.text = texts.sponsor

        copyrightLabel.font = UIFont.sponsorFont
        copyrightLabel.textColor = .slateTwo
        copyrightLabel.text = texts.copyright

        versionLabel.font = UIFont.versionFontTwo
        versionLabel.textColor = .greyblue50
        versionLabel.text = texts.version

        sections.forEach { (section) in
            let view = ExpandableView()
            view.configue(title: section.title, elements: section.texts)
            stackView.addArrangedSubview(view)
        }
    }
}
