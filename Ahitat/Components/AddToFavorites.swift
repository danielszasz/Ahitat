//
//  AddToFavorites.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/30/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

class AddToFavorites: UIActivity {
    override var activityTitle: String? {
        return "Add a kedvencekhez"
    }

    override class var activityCategory: UIActivity.Category {
        return .action
    }

    override var activityType: UIActivity.ActivityType? {
        return UIActivity.ActivityType(rawValue: "addToFavorites")
    }

    override var activityImage: UIImage? {
        return #imageLiteral(resourceName: "icon-bookmark-filled.png")
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }

    override func prepare(withActivityItems activityItems: [Any]) {
        //
    }

    override func perform() {
        activityDidFinish(true)
    }
}
