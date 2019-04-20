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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel.screenTitle

        iconImageView.image = UIImage(named: viewModel.icon)

        titleLabel.font = UIFont.proDisplaySemibold.changeSizeIfIpad
        titleLabel.textColor = .slateTwo
        titleLabel.text = viewModel.title

        descriptionLabel.font = UIFont.proDisplayRegular.changeSizeIfIpad
        descriptionLabel.textColor = .slateTwo
        descriptionLabel.text = viewModel.description

        sponsorLabel.font = UIFont.sponsorFont.changeSizeIfIpad
        sponsorLabel.textColor = .slateTwo
        sponsorLabel.text = viewModel.sponsor

        copyrightLabel.font = UIFont.sponsorFont.changeSizeIfIpad
        copyrightLabel.textColor = .slateTwo
        copyrightLabel.text = viewModel.copyright

        versionLabel.font = UIFont.versionFontTwo.changeSizeIfIpad
        versionLabel.textColor = .greyblue50
        versionLabel.text = viewModel.version

        viewModel.views.forEach { (view) in
            stackView.addArrangedSubview(view)
        }
    }
}
