enum SettingsCellType: Identifiable, CaseIterable {
    var id: Self { self }
    
    case notifications
    case aboutDeveloper
    case privacy
    
    var title: String {
        switch self {
            case .notifications:
                "Notifications"
            case .aboutDeveloper:
                "About the developer"
            case .privacy:
                "Privacy Policy"
        }
    }
    
    var urlString: String {
        switch self {
            case .aboutDeveloper:
                "https://sites.google.com/view/dovekeeperwhite/home"
            case .privacy:
                "https://sites.google.com/view/dovekeeperwhite/privacy-policy"
            default:
                ""
        }
    }
}
