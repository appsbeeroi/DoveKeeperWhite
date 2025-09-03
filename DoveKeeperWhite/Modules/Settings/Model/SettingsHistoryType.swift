enum SettingsHistoryType: Identifiable, CaseIterable {
    var id: Self { self }
    
    case sales
    case breeds
    
    var title: String {
        switch self {
            case .sales:
                "Sales"
            case .breeds:
                "Selected breeds"
        }
    }
}
