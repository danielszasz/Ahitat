//
//  DailyMeditation.swift
//  Ahitat
//
//  Created by Daniel Szasz on 9/16/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import Foundation

struct DailyMeditation: Decodable {
    let id: Int
    let date: Date
    let beforeNoon: Meditation
    let afterNoon: Meditation

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)

        let stringDate = try values.decode(String.self, forKey: .datum)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        date = dateFormatter.date(from: stringDate) ?? Date()

        let beforeTitle = try values.decode(String.self, forKey: .de_cim)
        let beforeAuthor = try values.decode(String.self, forKey: .de_szerzo)
        let beforeVerse = try values.decode(String.self, forKey: .de_ige)
        let beforeMedit = try values.decode(String.self, forKey: .de_szoveg)

        beforeNoon = Meditation(title: beforeTitle,
                                      verse: beforeVerse,
                                      meditation: beforeMedit,
                                      author: beforeAuthor)

        let afterTitle = try values.decode(String.self, forKey: .du_cim)
        let afterAuthor = try values.decode(String.self, forKey: .du_szerzo)
        let afterVerse = try values.decode(String.self, forKey: .du_ige)
        let afterMedit = try values.decode(String.self, forKey: .du_szoveg)

        afterNoon = Meditation(title: afterTitle,
                                      verse: afterVerse,
                                      meditation: afterMedit,
                                      author: afterAuthor)

    }
}


extension DailyMeditation {
    enum CodingKeys: String, CodingKey {
        case id
        case datum
        case de_cim
        case de_szoveg
        case de_ige
        case de_szerzo
        case du_cim
        case du_szoveg
        case du_ige
        case du_szerzo

    }
}
