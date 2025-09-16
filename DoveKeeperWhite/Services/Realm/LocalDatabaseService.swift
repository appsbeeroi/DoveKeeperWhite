import Foundation
import SwiftUI

final class LocalDatabaseService: ObservableObject {
    
    static let shared = LocalDatabaseService()
    
    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private init() {}
}

// MARK: - Public API
extension LocalDatabaseService {
    
    func insert<T: Codable & Identifiable>(_ item: T) async where T.ID == UUID {
        let key = storageKey(for: T.self)
        var items = await fetchAll(T.self)
        
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
        } else {
            items.append(item)
        }
        
        save(items, forKey: key)
    }
    
    func fetchAll<T: Codable>(_ type: T.Type = T.self) async -> [T] {
        let key = storageKey(for: T.self)
        guard let data = defaults.data(forKey: key) else { return [] }
        
        do {
            return try decoder.decode([T].self, from: data)
        } catch {
            print("❌ Failed to decode \(T.self): \(error.localizedDescription)")
            return []
        }
    }
    
    func remove<T: Codable & Identifiable>(_ type: T.Type, primaryKey: UUID) async where T.ID == UUID {
        var items = await fetchAll(T.self)
        items.removeAll { $0.id == primaryKey }
        let key = storageKey(for: T.self)
        save(items, forKey: key)
    }
    
    func clearAll<T: Codable>(_ type: T.Type) async {
        let key = storageKey(for: T.self)
        defaults.removeObject(forKey: key)
    }
}

// MARK: - Helpers
private extension LocalDatabaseService {
    func storageKey<T>(for type: T.Type) -> String {
        "LocalDB_\(String(describing: type))"
    }
    
    func save<T: Codable>(_ items: [T], forKey key: String) {
        do {
            let data = try encoder.encode(items)
            defaults.set(data, forKey: key)
        } catch {
            print("❌ Failed to encode \(T.self): \(error.localizedDescription)")
        }
    }
}
