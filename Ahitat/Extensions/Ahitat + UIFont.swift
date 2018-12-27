//
//  Ahitat + UIFont.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/26/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

extension UIFont {
    class var systemFontLight: UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: .light)
    }

    class var systemFontSemibold: UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: .semibold)
    }

    class var dayNumber: UIFont {
        return UIFont.systemFont(ofSize: 16.0, weight: .regular)
    }

    class var dayText: UIFont {
        return UIFont.systemFont(ofSize: 10.0, weight: .regular)
    }

    class var systemMedium: UIFont {
        return UIFont.systemFont(ofSize: 16.0, weight: .medium)
    }

    class var georgiaItalic: UIFont {
        return UIFont(name: "Georgia-Italic", size: 16.0)!
    }
}
