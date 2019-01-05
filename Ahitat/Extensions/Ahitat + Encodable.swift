//
//  Ahitat + Encodable.swift
//  Ahitat
//
//  Created by Daniel Szasz on 1/5/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

public extension Encodable {
    var json: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
