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
        var favorites = getFavorites()
        favorites.append(model)

        save(favorites: favorites)
    }

    func delete(model: FavoriteModel) {
        var favorites = getFavorites()
        guard let index = favorites.firstIndex(of: model) else {return}
        favorites.remove(at: index)

        save(favorites: favorites)
    }

    func isFavorite(with id: Int, isAfterNoon: Bool) -> Bool {
        let favorites = getFavorites()
        let isFavorite = favorites.contains(where: {$0.id == id && $0.isAfternoon == isAfterNoon})
        return isFavorite
    }

    private func save(favorites: [FavoriteModel]) {
        guard let encoded = try? JSONEncoder().encode(favorites) else {return}
        userDefaults.set(encoded, forKey: "favorites")
    }

    func getFavorites() -> [FavoriteModel] {
        guard let data = userDefaults.data(forKey: "favorites"),
            let favorites = try? JSONDecoder().decode([FavoriteModel].self, from: data) else {return []}
        return favorites
    }
}
