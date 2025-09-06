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
    @Persisted var parent = List<PigeonObject>()
    @Persisted var birthDate: Date?
    @Persisted var chickCount: String
    
    convenience init(from model: Pigeon, and imagePath: String, parents: [(Pigeon, imagePath: String)]? = nil) {
        self.init()
        self.id = model.id
        self.name = model.name
        self.age = model.age
        self.status = model.status ?? .adult
        self.notes = model.notes
        self.imagePath = imagePath
        self.birthDate = model.birthDate
        self.chickCount = model.chickCount
        
        model.cares.forEach {
            self.cares.append(CareObject(from: $0))
        }
        
        if let parents {
            parents.forEach { parent, imagePath in
                self.parent.append(PigeonObject(from: parent, and: imagePath))
            }
        }
    }
}
