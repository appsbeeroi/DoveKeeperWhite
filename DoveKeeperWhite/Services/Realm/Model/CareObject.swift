import RealmSwift
import Foundation

final class CareObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var type: CareType
    @Persisted var date: Date
    @Persisted var notes: String
    
    convenience init(from model: Care) {
        self.init()
        self.id = model.id
        self.type = model.type ?? .cleansing
        self.date = model.date
        self.notes = model.notes
    }
}
