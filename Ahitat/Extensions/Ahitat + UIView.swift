//
//  Ahitat + UIView.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/30/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

extension UIView {

    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0.0, height: 3.0),
                   shadowOpacity: Float = 0.16,
                   shadowRadius: CGFloat = 6.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
