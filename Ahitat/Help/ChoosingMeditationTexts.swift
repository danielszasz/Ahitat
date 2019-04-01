//
//  ChoosingMeditationsTexts.swift
//  Ahitat
//
//  Created by Daniel Szasz on 4/1/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

struct ChoosingMeditationTexts: ExpandableSection {
    var title: String {
        return "Az olvasni kívánt áhitat kiválasztása"
    }

    var texts: [NSAttributable] {
        let first = NSAttributable(text: "Az applikáció indítás után az aznapi dátumra írt áhitatot nyitja meg. A délelőtti és a délutáni sorozat is egy oldalon található. A délutánihoz lejjebb kell görgetni / húzni az oldalt amíg az megjelenik.\n\n", image: "")
        let second = NSAttributable(text: "Amennyiben egy korábbi áhitatot szeretnénk elolvasni, koppintsunk a naptár iconra", image: "")
        let third = NSAttributable(text: "", image: "iconCalendar")
        let fourth = NSAttributable(text: "és a lenyíló interaktív naptáron válasszuk ki a kívánt dátumot.\n\n", image: "")
        let fifth = NSAttributable(text: "Ha kissé elkeveredtünk a korábbi dátumok között és gyorsan az aznapi áhitathoz szeretnénk jutni, koppintsunk ismét a naptár iconra", image: "")
        let sixth = NSAttributable(text: "", image: "iconCalendar")
        let seventh = NSAttributable(text: ", majd a 'Mai Áhitat'gombra a naptár jobb alsó sarkában.", image: "")
        return [first, second, third, fourth, fifth, sixth, seventh]
    }
}
