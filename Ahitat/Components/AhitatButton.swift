//
//  AhitatButton.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/27/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

class AhitatButton: UIButton {

    override var intrinsicContentSize: CGSize {
        let contentSize = super.intrinsicContentSize

        let adjustedWidth = contentSize.width + imageEdgeInsets.left + imageEdgeInsets.right
        let adjustedHeight = contentSize.height + imageEdgeInsets.top + imageEdgeInsets.bottom

        return CGSize(width: adjustedWidth, height: adjustedHeight)

    }
}
