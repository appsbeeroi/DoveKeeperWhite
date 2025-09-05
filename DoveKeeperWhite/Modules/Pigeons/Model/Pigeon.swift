import UIKit

struct Pigeon: Identifiable {
    let id: UUID
    var name: String
    var age: String
    var status: PigeonStatus?
    var notes: String
    var image: UIImage?
    var cares: [Care]
    
    var isUnlock: Bool {
        name != "" && age != "" && status != nil && image != nil
    }
    
    init(isReal: Bool) {
        self.id = UUID()
        self.name = isReal ? "" : "Pigeon"
        self.age = isReal ? "" : "1"
        self.cares = isReal ? [] : [Care(isReal: false), Care(isReal: false), Care(isReal: false)]
        self.notes = isReal ? "" : "Hello, I am a pigeon!"
        self.status = isReal ? nil : .adult
    }
    
    init(from object: PigeonObject, and image: UIImage) {
        self.id = object.id
        self.name = object.name
        self.age = object.age
        self.status = object.status
        self.notes = object.notes
        self.image = image
        self.cares = object.cares.map { Care(from: $0) }
    }
}



