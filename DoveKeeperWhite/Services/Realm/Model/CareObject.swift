import Foundation

struct CareObject: Codable {
    var id: UUID
    var type: CareType
    var date: Date
    var notes: String
    
    init(from model: Care) {
        self.id = model.id
        self.type = model.type ?? .cleansing
        self.date = model.date
        self.notes = model.notes
    }
}
