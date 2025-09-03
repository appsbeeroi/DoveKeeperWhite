enum QuicksandFontWeight {
    case semibold
    case bold
    
    var name: String {
        switch self {
            case .semibold:
                "Quicksand-SemiBold"
            case .bold:
                "Quicksand-Bold"
        }
    }
}
