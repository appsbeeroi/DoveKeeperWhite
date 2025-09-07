import UIKit

struct Sale: Identifiable, Equatable {
    let id: UUID
    var pigeons: [Pigeon]
    var date: Date
    var price: String
    
    var isUnlock: Bool {
        !pigeons.isEmpty && price != ""
    }
    
    init(isReal: Bool) {
        self.id = UUID()
        self.pigeons = isReal ? [] : [Pigeon(isReal: false), Pigeon(isReal: false)]
        self.date = Date()
        self.price = isReal ? "" : "1"
    }
    
    init(from object: SaleObject) {
        self.id = object.id
        self.pigeons = Array(object.pigeons.map { Pigeon(from: $0, and: nil) })
        self.date = object.date
        self.price = object.price
    }
}


