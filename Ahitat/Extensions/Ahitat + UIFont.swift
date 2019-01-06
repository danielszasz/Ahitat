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

    class var georgiaBoldItalic: UIFont {
        return UIFont(name: "Georgia-BoldItalic", size: 16.0)!
    }

    class var proDisplaySemiboldItalic: UIFont {
        return UIFont(name: "SFProDisplay-SemiboldItalic", size: 16.0)!
    }

    class var proDisplaySemibold: UIFont {
        return UIFont(name: "SFProDisplay-Semibold", size: 20.0)!
    }

    class var menuTitleLabel: UIFont {
        return UIFont(name: "SFProDisplay-Semibold", size: 26.0)!
    }

    class var authorLabel: UIFont {
        return UIFont(name: "SFProDisplay-Semibold", size: 16.0)!
    }

    class var proDisplayRegular: UIFont {
        return UIFont(name: "SFProDisplay-Regular", size: 16.0)!
    }

    class var versionFont: UIFont {
        return UIFont(name: "SFProDisplay-Regular", size: 12.0)!
    }

    var changeSizeIfIpad: UIFont {
        let size = self.pointSize
        let finalSize = UIDevice.current.userInterfaceIdiom == .pad ? size + 6 : size
        return self.withSize(finalSize)
    }
}
