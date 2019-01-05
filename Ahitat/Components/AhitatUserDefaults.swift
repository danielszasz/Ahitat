//
//  AhitatUserDefaults.swift
//  Ahitat
//
//  Created by Daniel Szasz on 1/5/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

class AhitatUserDefaults {
    private var userDefaults: UserDefaults {
        return UserDefaults.standard
    }

    func add(model: FavoriteModel) {
        if let data = userDefaults.data(forKey: "favorites"),
            var favorites = try? JSONDecoder().decode([FavoriteModel].self, from: data) {
            favorites.append(model)

            guard let encoded = try? JSONEncoder().encode(favorites) else {return}
            userDefaults.set(encoded, forKey: "favorites")
        } else {
            guard let encoded = try? JSONEncoder().encode([model]) else {return}
            userDefaults.set(encoded, forKey: "favorites")
        }
    }
}
