//
//  AboutScreenTexts.swift
//  Ahitat
//
//  Created by Daniel Szasz on 4/12/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import UIKit

struct AboutScreenTexts: InfoScreenViewModel {
    var title: String {
        return "Miért és kinek?!"
    }

    var icon: String {
        return "iconInfo"
    }

    var description: String {
        return "A napi áhitatok fontosak a lelki emberek számára. Kikre gondolunk itt? Azokra a személyekre akiknek már volt találkozásuk a Krisztussal, vagy szeretnék Őt megismerni.\n\n Korunkban a digitális média fontos szerepet tölt be az emberek életében mivel sokszor kényelmesebb a használata mint a könyvek lapozása. Egy hatalmas előnye a nyomtatványokkal szemben, hogy mindig kéznél van és nem utolsó sorban, természetbarát, egy fát sem kellett kivágjanak a kiadványok létrehozásához. \n\n Pontosítva a célközönséget, ez az applikáció azok számára készült, akik szívesen használnak mobil eszközöket Biblia olvasásra, vagy lelki táplálékok keresésére. A keresztény Biblia értékeit hivatott továbbítani az emberiség számára, ami 'Istentől ihletett, és hasznos a tanításra, a feddésre, a megjobbításra, az igazságban való nevelésre; hogy tökéletes legyen az Isten embere, minden jó cselekedetre felkészített.' (2 Timóteus 3:16-17)"
    }

    var views: [UIView] {
        return [WeMadeThisView()]
    }
}
