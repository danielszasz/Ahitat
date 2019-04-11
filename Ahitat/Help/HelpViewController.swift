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
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var sponsorLabel: UILabel!
    @IBOutlet private weak var copyrightLabel: UILabel!
    @IBOutlet private weak var versionLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!

    private let viewModel: InfoScreenViewModel

    init(viewModel: InfoScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HelpViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iconImageView.image = UIImage(named: viewModel.icon)

        titleLabel.font = UIFont.proDisplaySemibold
        titleLabel.textColor = .slateTwo
        titleLabel.text = viewModel.title

        descriptionLabel.font = UIFont.proDisplayRegular
        descriptionLabel.textColor = .slateTwo
        descriptionLabel.text = viewModel.description

        sponsorLabel.font = UIFont.sponsorFont
        sponsorLabel.textColor = .slateTwo
        sponsorLabel.text = viewModel.sponsor

        copyrightLabel.font = UIFont.sponsorFont
        copyrightLabel.textColor = .slateTwo
        copyrightLabel.text = viewModel.copyright

        versionLabel.font = UIFont.versionFontTwo
        versionLabel.textColor = .greyblue50
        versionLabel.text = viewModel.version

        viewModel.views.forEach { (view) in
            stackView.addArrangedSubview(view)
        }
    }
}
