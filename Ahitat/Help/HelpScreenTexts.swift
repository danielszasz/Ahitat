//
//  HelpScreenTexts.swift
//  Ahitat
//
//  Created by Daniel Szasz on 4/1/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

protocol ExpandableSection {
    var title: String {get}
    var texts: [NSAttributable] {get}
}

struct HelpScreenTexts {
    var title: String {
        return "Mit és hogyan?!"
    }

    var description: String {
        return "Egy új applikáció használata néha nehézségekkel jár. Ez az oldal arra hivatott, hogy az Áhitat App használatának kezdeti lépéseiben segítsünk. Bár törekedtünk egy letisztult  felület létrehozására és az egyszerű kezelhetőségre, mégis jól jöhet egy kis segítség."
    }

    var sponsor: String {
        return "Készült a Romániai Magyar Baptista Szövetség \nhozzájárulásával."
    }

    var copyright: String {
        return  "© 2018-2019 Minden jog fenntartva."
    }

    var version: String {
        return Bundle.main.getVersionString()
    }
}
