//
//  ExpandableView.swift
//  Ahitat
//
//  Created by Daniel Szasz on 3/23/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import UIKit

class ExpandableView: CustomView {
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var attachmentView: TextWithAttachmentView!
    @IBOutlet private weak var expandableIndicator: UILabel!

    override func configureUI() {
        super.configureUI()

    }
}
