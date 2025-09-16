enum PigeonStatus: String, Identifiable, CaseIterable, Codable, Equatable {
    var id: Self { self }
    
    case adult
    case young
    case sale
    
    var title: String {
        switch self {
            case .adult:
                "Adult"
            case .young:
                "Young"
            case .sale:
                "For sale"
        }
    }
    
    var icon: String {
        switch self {
            case .adult:
                "🕊️"
            case .young:
                "🐣"
            case .sale:
                "💰"
        }
    }
}
