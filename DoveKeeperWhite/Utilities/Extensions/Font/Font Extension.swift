import SwiftUI

extension Font {
    static func quicksand(size: CGFloat, _ weight: QuicksandFontWeight) -> Font {
        .custom(weight.name, size: size)
    }
}
