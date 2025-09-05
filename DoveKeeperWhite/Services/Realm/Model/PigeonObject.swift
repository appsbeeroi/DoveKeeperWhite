import RealmSwift
import Foundation

final class PigeonObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var name: String
    @Persisted var age: String
    @Persisted var status: PigeonStatus
    @Persisted var notes: String
    @Persisted var imagePath: String
    @Persisted var cares = List<CareObject>()
    
    convenience init(from model: Pigeon, and imagePath: String) {
        self.init()
        self.id = model.id
        self.name = model.name
        self.age = model.age
        self.status = model.status ?? .adult
        self.notes = model.notes
        self.imagePath = imagePath
        
        model.cares.forEach {
            self.cares.append(CareObject(from: $0))
        }
    }
}
