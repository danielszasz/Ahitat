//
//  CalendarView.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/26/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

class CalendarView: CustomView {

    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var calendarCollectionView: UICollectionView!
    @IBOutlet private weak var currentDayLabel: UILabel!

    override func configureUI() {
        leftButton.setImage(#imageLiteral(resourceName: "iconBackChevron.png"), for: .normal)

        rightButton.setImage(#imageLiteral(resourceName: "iconForwardChevron.png"), for: .normal)


    }
}

extension CalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension CalendarView: UICollectionViewDelegate {

}
