//
//  OpeningTheBibleTexts.swift
//  Ahitat
//
//  Created by Daniel Szasz on 4/12/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

struct OpeningTheBibleTexts: ExpandableSection {
    var title: String {
        return "Biblia rész megnyitása"
    }

    var texts: [NSAttributable] {
        let first = NSAttributable(text: "Az iOS Áhitat App nem tartalmaz beépített Bibliát. Amennyiben ezt a funkciót fontosnak találod, kérlek jelezd a készítőknek. Addig is a mindenki számára elérhető online biblia használatát javasoljuk, ami a fő menüre ", image: "")
        let second = NSAttributable(text: "", image: "iconHamburgerMenu")
        let third = NSAttributable(text: " koppintva, majd az ", image: "")
        let fourth = NSAttributable(text: "", image: "iconBible")
        let fifth = NSAttributable(text: " Online Biblia külső hivatkozást kiválasztva, automatikusan az aznapi áhitathoz tartozó Igerészt nyitja meg a mobil eszközöd internetes böngészőjén.", image: "")
        return [first, second, third, fourth, fifth]
    }
}
