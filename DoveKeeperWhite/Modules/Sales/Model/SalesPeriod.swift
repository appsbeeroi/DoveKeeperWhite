enum SalesPeriod: Identifiable, CaseIterable {
    var id: Self { self }
    
    case month
    case year
    
    var title: String {
        switch self {
            case .month:
                "Month"
            case .year:
                "Year"
        }
    }
}
