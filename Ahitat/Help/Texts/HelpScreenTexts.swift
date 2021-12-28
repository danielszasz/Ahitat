//
//  HelpScreenTexts.swift
//  Ahitat
//
//  Created by Daniel Szasz on 4/1/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import UIKit

protocol ExpandableSection {
    var title: String {get}
    var texts: [NSAttributable] {get}
}

protocol InfoScreenViewModel {
    var screenTitle: String {get}
    var title: String {get}
    var icon: String {get}
    var description: String {get}
    var sponsor: String {get}
    var copyright: String {get}
    var version: String {get}

    var views: [UIView] {get}
}

extension InfoScreenViewModel {

    var sponsor: String {
        return "Készült a Romániai Magyar Baptista Szövetség \nhozzájárulásával."
    }

    var copyright: String {
        return  "© 2018-2022 Minden jog fenntartva."
    }

    var version: String {
        return Bundle.main.getVersionString()
    }
}

class HelpScreenTexts: InfoScreenViewModel {
    var screenTitle: String {
        return "Segítség"
    }
    
    var title: String {
        return "Mit és hogyan?!"
    }

    var icon: String {
        return "iconHelp"
    }

    var description: String {
        return "Egy új applikáció használata néha nehézségekkel jár. Ez az oldal arra hivatott, hogy az Áhitat App használatának kezdeti lépéseiben segítsünk. Bár törekedtünk egy letisztult  felület létrehozására és az egyszerű kezelhetőségre, mégis jól jöhet egy kis segítség."
    }

    var views: [UIView] = []

    init() {
        views = generateViews()
    }


    func generateViews() -> [UIView] {
        let sections: [ExpandableSection] = [ChoosingMeditationTexts(), OpeningTheBibleTexts(),
                                             HandelingFavorites(), ShareMeditationsTexts(), SendFeedbackTexts()]

        return sections.enumerated().map { (index, section) in
            return getView(for: section, and: index)
        }
    }

    func getView(for section: ExpandableSection, and index: Int) -> UIView {
        let view = ExpandableView()
        view.configue(title: section.title, elements: section.texts, isExpanded: index == 0, viewPressed: { tappedView in
            guard let filteredViews = self.views.filter({$0 != tappedView}) as? [ExpandableView] else {return}
            filteredViews.forEach({$0.close()})
        })

        return view
    }
}
