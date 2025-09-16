import Foundation

struct PigeonObject: Codable, Identifiable {
    var id: UUID
    var name: String
    var age: String
    var status: PigeonStatus
    var notes: String
    var imagePath: String
    var cares: [CareObject]
    var parent: [PigeonObject] = []
    var birthDate: Date?
    var chickCount: String
    var isSold: Bool
    
    init(from model: Pigeon, and imagePath: String, parents: [(Pigeon, imagePath: String)]? = nil) {
        self.id = model.id
        self.name = model.name
        self.age = model.age
        self.status = model.status ?? .adult
        self.notes = model.notes
        self.imagePath = imagePath
        self.birthDate = model.birthDate
        self.chickCount = model.chickCount
        self.isSold = model.isSold
        self.cares = model.cares.map { CareObject(from: $0) }
      
        if let parents {
            parents.forEach { parent, imagePath in
                self.parent.append(PigeonObject(from: parent, and: imagePath))
            }
        }
    }
}
