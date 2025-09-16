import Foundation

struct SaleObject: Codable, Identifiable {
    var id: UUID
    var pigeons: [PigeonObject]
    var date: Date
    var price: String
    
    init(from model: Sale) {
        self.id = model.id
        self.date = model.date
        self.price = model.price
        self.pigeons = model.pigeons.map { PigeonObject(from: $0, and: "")}
    }
}
