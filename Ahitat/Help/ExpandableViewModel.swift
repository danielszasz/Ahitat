//
//  ExpandableViewModel.swift
//  Ahitat
//
//  Created by Daniel Szasz on 3/24/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

struct ExpandableViewModel {
    var title: String
    var isSelected: Box<Bool>
    var attachments: [NSAttributable]
}
