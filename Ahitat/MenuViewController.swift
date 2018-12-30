//
//  MenuViewController.swift
//  Ahitat
//
//  Created by Daniel Szasz on 9/14/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        separatorView.backgroundColor = .iceBlue
        
        titleLabel.textColor = .slateTwo
        titleLabel.font = UIFont.menuTitleLabel
        titleLabel.text = "Áhitat"

        versionLabel.textColor = .slateTwo
        versionLabel.font = UIFont.versionFont
        versionLabel.text = "v1.0.0"

        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
