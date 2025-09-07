import Foundation
import RealmSwift

final class SaleObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var pigeons = List<PigeonObject>()
    @Persisted var date: Date
    @Persisted var price: String
    
    convenience init(from model: Sale) {
        self.init()
        self.id = model.id
        self.date = model.date
        self.price = model.price
        
        model.pigeons.forEach {
            self.pigeons.append(PigeonObject(from: $0, and: ""))
        }
    }
}
