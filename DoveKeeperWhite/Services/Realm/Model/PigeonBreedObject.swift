import RealmSwift
import Foundation

final class PigeonBreedObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var isFavorite: Bool
    
    convenience init(from model: PigeonBreed) {
        self.init()
        self.id = model.uuid
        self.isFavorite = model.isFavorite
    }
}
