import Foundation

struct PigeonBreedObject: Codable, Identifiable {
    var id: UUID
    var isFavorite: Bool
    
    init(from model: PigeonBreed) {
        self.id = model.uuid
        self.isFavorite = model.isFavorite
    }
}
