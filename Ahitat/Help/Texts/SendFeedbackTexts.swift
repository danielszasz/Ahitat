//
//  SendFeedback.swift
//  Ahitat
//
//  Created by Daniel Szasz on 4/12/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

struct SendFeedbackTexts: ExpandableSection {
    var title: String {
        return "Visszajelzés küldése"
    }

    var texts: [NSAttributable] {
        let first = NSAttributable(text: "Először is hadd köszönjük meg, hogy az általunk készített iOS Applikációt használod! Ha bármilyen észrevételed vagy ötleted van az applikációval kapcsolatban, keress fel minket bátran. Írj a készítők egyikének (daniel.szasz88@gmail.com vagy arpad.szucs@gmail.com) és írd le visszajelzésed. Igyekszünk minden kedves felhasználónak válaszolni.", image: "")
        return [first]
    }
}
