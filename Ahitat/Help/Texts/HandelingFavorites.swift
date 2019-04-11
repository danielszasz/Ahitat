//
//  HandelingFavorites.swift
//  Ahitat
//
//  Created by Daniel Szasz on 4/12/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

struct HandelingFavorites: ExpandableSection {
    var title: String {
        return "Kedvencek kezelése"
    }

    var texts: [NSAttributable] {
        let first = NSAttributable(text: "Az applikációban lehetőség van egyes áhitatok hozzáadásához a kedvencek listához. Ez a funkció arra hasznos, hogy ha egyik írás megtetszik, vagy szól hozzánk akkor el tudjuk menteni egy külön listába, úgynevezett 'kedvencek' közé, amiben könnyedén visszakereshetővé vállnak a számunkra kedves írások.\n\n", image: "")
        let second = NSAttributable(text: "Egy áhitatot a bejegyzés fejlécében található csillag ", image: "")
        let third = NSAttributable(text: "", image: "iconFavorites0")
        let fourth = NSAttributable(text: " iconra koppintva adhatunk a kedvencek listájához. A hozzáadás visszaigazolásaként a csupán körvonalakból álló csillag 'betelik'", image: "")
        let fifth = NSAttributable(text: "", image: "iconFavorites1")
        let sixth = NSAttributable(text: " . Újbóli koppintással a csillagra, a bejegyzést azonnal eltávolíthatjuk a kedvencek közül. A megjelölt áhitatokat a kedvencek oldalról is ( ", image: "")
        let seventh = NSAttributable(text: "", image: "iconBookmarks")
        let eight = NSAttributable(text: " Kedvencek) eltávolíthatunk. Ezt az eltávolítani kívánt áhitat balra húzásával majd a törlés megerősítésével tehetjük meg.", image: "")
        return [first, second, third, fourth, fifth, sixth, seventh, eight]
    }
}
