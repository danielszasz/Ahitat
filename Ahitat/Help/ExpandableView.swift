//
//  ExpandableView.swift
//  Ahitat
//
//  Created by Daniel Szasz on 3/23/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import UIKit

class ExpandableView: CustomView {
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var attachmentView: TextWithAttachmentView!
    @IBOutlet private weak var expandableIndicator: UILabel!
    private var viewPressed: (UIView) -> Void = {_ in}

    override func configureUI() {
        super.configureUI()
        titleLable.font = UIFont.authorLabel
        titleLable.textColor = .slateTwo
        separatorView.backgroundColor = .paleBlue

        expandableIndicator.textColor = .slateTwo
        expandableIndicator.font = .authorLabel
        expandableIndicator.text = "+"
        attachmentView.isHidden = true
        addTap()
    }

    func configue(title: String, elements: [NSAttributable], isExpanded: Bool, viewPressed: @escaping (UIView) -> Void) {
        titleLable.text = title
        attachmentView.configure(elements: elements)
        self.viewPressed = viewPressed
        if isExpanded {
            open()
        }
    }

    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggle))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
    }

    @IBAction private func toggle() {
        attachmentView.isHidden ? open() : close()
        viewPressed(self)
    }

    func close() {
        attachmentView.isHidden = true
        expandableIndicator.text = "+"
    }

    func open() {
        attachmentView.isHidden = false
        expandableIndicator.text = "_"
    }
}
