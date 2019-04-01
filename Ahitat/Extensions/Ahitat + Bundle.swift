//
//  Ahitat + Bundle.swift
//  Ahitat
//
//  Created by Daniel Szasz on 4/1/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

extension Bundle {
    func getVersionString() -> String {
        let infoDictionary = Bundle.main.infoDictionary ?? [:]
        let appVersion = infoDictionary["CFBundleShortVersionString"] as? String
        return appVersion ?? ""
    }
}

