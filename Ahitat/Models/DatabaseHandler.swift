//
//  DatabaseHandler.swift
//  Ahitat
//
//  Created by Daniel Szasz on 9/15/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import SQLite
import Foundation

final class DatabaseHandler {
    private var database: Connection? {
        let path = Bundle.main.path(forResource: "devotional2023", ofType: "sqlite") ?? ""
        return try? Connection(path, readonly: true)
    }

    func getMeditations() -> [DailyMeditation] {
        let meditations = Table("ahitatok")

        do {
            let dailyMeditations: [DailyMeditation] = try database?.prepare(meditations).map { row in
                return try row.decode()
                } ?? []

            return dailyMeditations
        } catch {
            print(error)
            return []
        }
    }
}
