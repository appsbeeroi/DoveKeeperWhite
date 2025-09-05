import Foundation

struct Care: Identifiable {
    let id: UUID
    var type: CareType?
    var date: Date
    var notes: String
    
    var isUnlock: Bool {
        type != nil && notes != ""
    }
    
    init(isReal: Bool) {
        self.id = UUID()
        self.type = isReal ? nil : CareType.allCases.randomElement()
        self.date = Date()
        self.notes = isReal ? "" : "Lorem ipsum dolor sit amet."
    }
    
    init(from object: CareObject) {
        self.id = object.id
        self.type = object.type
        self.date = object.date
        self.notes = object.notes
    }
}

