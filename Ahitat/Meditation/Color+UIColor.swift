import SwiftUI
import UIKit

/// Convenience to convert a SwiftUI `Color` into a UIKit `UIColor`.
public extension Color {
    /// Returns a `UIColor` representation of this SwiftUI `Color`.
    var uiColor: UIColor {
        // With modern iOS minimums, this initializer is available and reliable
        return UIColor(self)
    }
}
