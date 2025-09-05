import RealmSwift

enum CareType: String, Identifiable, CaseIterable, PersistableEnum {
    var id: Self { self }
    
    case feeding
    case cleansing
    case vaccination
    
    var title: String {
        switch self {
            case .feeding:
                "Feeding"
            case .cleansing:
                "Cleansing"
            case .vaccination:
                "Vaccination"
        }
    }
    
    var icon: String {
        switch self {
            case .feeding:
                "🍽️"
            case .cleansing:
                "🧹"
            case .vaccination:
                "💉"
        }
    }
}

