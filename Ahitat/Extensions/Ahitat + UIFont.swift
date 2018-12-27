//
//  Ahitat + UIFont.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/26/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

extension UIFont {
    class var systemFont: UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: .regular)
    }

    class var georgiaItalic: UIFont {
        return UIFont(name: "Georgia-Italic", size: 16.0)!
    }
}
