//
//  Ahitat + UIScrollView.swift
//  Ahitat
//
//  Created by Daniel Szasz on 1/6/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y,width: 1,height: self.frame.height), animated: animated)
        }
    }
}
