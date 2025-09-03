import Foundation
import RealmSwift

final class LocalDatabaseService: ObservableObject {

    static let shared = LocalDatabaseService()
    
    private var database: Realm?
    
    private init() {
        Task {
            await initializeRealm()
        }
    }
    
    @RealmActor
    private func initializeRealm() async {
        do {
            database = try await Realm(actor: RealmActor.shared)
        } catch {
            print("❌ Realm initialization failed: \(error.localizedDescription)")
        }
    }
}

// MARK: - Public API
extension LocalDatabaseService {
    
    @RealmActor
    func insert<T: Object>(_ item: T) async {
        guard let database else {
            print("❌ Realm not ready")
            return
        }
        
        do {
            try database.write {
                database.add(item, update: .all)
            }
        } catch {
            print("❌ Failed to insert item: \(error.localizedDescription)")
        }
    }

    @RealmActor
    func fetchAll<T: Object>() async -> [T] {
        while database == nil {
            await Task.yield()
        }
        
        guard let database else {
            print("❌ Realm not ready")
            return []
        }
        
        return Array(database.objects(T.self))
    }
    
    @RealmActor
    func remove<T: Object>(_ type: T.Type, primaryKey: UUID) async {
        guard let database else {
            print("❌ Realm not ready")
            return
        }
        
        guard let target = database.object(ofType: type, forPrimaryKey: primaryKey) else {
            print("⚠️ No item found for key: \(primaryKey)")
            return
        }
        
        do {
            try database.write {
                database.delete(target)
            }
        } catch {
            print("❌ Failed to remove item: \(error.localizedDescription)")
        }
    }
    
    @RealmActor
    func clearAll() async {
        guard let database else {
            print("❌ Realm not ready")
            return
        }
        
        do {
            try database.write {
                database.deleteAll()
            }
        } catch {
            print("❌ Failed to clear database: \(error.localizedDescription)")
        }
    }
}
