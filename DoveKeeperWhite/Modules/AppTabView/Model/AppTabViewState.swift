enum AppTabViewState: Identifiable, CaseIterable {
    var id: Self { self }
    
    case directory
    case pigeons
    case offspring
    case sales
    case settings
    
    var title: String {
        switch self {
            case .directory:
                "Directory"
            case .pigeons:
                "My pigeons"
            case .offspring:
                "Offsping"
            case .sales:
                "Sales"
            case .settings:
                "Settings"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .directory:
                    .Images.TabView.directory
            case .pigeons:
                    .Images.TabView.pigeons
            case .offspring:
                    .Images.TabView.offsping
            case .sales:
                    .Images.TabView.sales
            case .settings:
                    .Images.TabView.settings
        }
    }
}
