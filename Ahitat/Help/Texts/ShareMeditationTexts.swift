//
//  ShareMeditationTexts.swift
//  Ahitat
//
//  Created by Daniel Szasz on 4/12/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

struct ShareMeditationsTexts: ExpandableSection {
    var title: String {
        return "Áhitatok megosztása"
    }

    var texts: [NSAttributable] {
        let first = NSAttributable(text: "Lehetőségünk van egy általunk kedvelt áhitatot megosztani ismerőseinkkel. Ezt az áhitatok fejlécében, a kedvencek megjelölésére használt csillag melletti megosztás iconra ", image: "")
        let second = NSAttributable(text: "", image: "iconShare")
        let third = NSAttributable(text: " koppintva tehetjük meg.  A megosztási lehetőségeket a mobil eszközünkre előzőleg telepített szociális média és más applikációk határozzák meg.", image: "")
        return [first, second, third]
    }
}
