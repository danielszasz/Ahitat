//
//  LinkConstructor.swift
//  Ahitat
//
//  Created by Daniel Szasz on 4/15/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

class LinkConstructor {
    private var baseUrl: String {
        return "https://abibliamindenkie.hu/uj"
    }
    func getLink(book: String, chapter: String, firstVerse: String) -> String {
        let abbreviation = BibleBookManager.getAbbreviation(book: book)
        return "\(baseUrl)/\(abbreviation)/\(chapter)/#\(firstVerse)"
    }
}
