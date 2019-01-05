//
//  FavoriteModel.swift
//  Ahitat
//
//  Created by Daniel Szasz on 1/4/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

struct FavoriteModel: Equatable {
    let author: String
    let date: Date
    let title: String
    let isAfternoon: Bool
}

extension FavoriteModel: Codable {

}
