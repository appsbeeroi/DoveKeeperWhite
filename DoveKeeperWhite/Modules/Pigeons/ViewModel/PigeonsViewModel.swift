import UIKit

final class PigeonsViewModel: ObservableObject {
    
    private let database = LocalDatabaseService.shared
    private let imageManager = ImageManager.shared
    
    @Published private(set) var pigeons: [Pigeon] = []
    
    @Published private(set) var isCloseActiveNavigation = false
    
    func loadPigeons() {
        Task { @RealmActor [weak self] in
            guard let self else { return }
            
            let objects: [PigeonObject] = await database.fetchAll()
            
            let result: [Pigeon] = await withTaskGroup(of: Pigeon?.self) { @RealmActor group in
                for object in objects {
                    group.addTask { @RealmActor in
                        guard let image = await self.imageManager.retrieve(fileNamed: object.id.uuidString) else { return nil }
                        let model = Pigeon(from: object, and: image)
                        
                        return model
                    }
                }
                
                var pigeons: [Pigeon?] = []
                
                for await pigeon in group {
                    pigeons.append(pigeon)
                }
                
                return pigeons.compactMap { $0 }
            }
            
            await MainActor.run {
                self.pigeons = result
            }
        }
    }
    
    func save(_ pigeon: Pigeon) {
        Task { @RealmActor [weak self] in
            guard let self,
                  let image = pigeon.image else { return }
            
            guard let imagePath = await imageManager.store(image: image, for: pigeon.id) else { return }
            let object = PigeonObject(from: pigeon, and: imagePath)
            
            await database.insert(object)
            
            await MainActor.run {
                if let index = self.pigeons.firstIndex(where: { $0.id == pigeon.id }) {
                    self.pigeons[index] = pigeon
                } else {
                    self.pigeons.append(pigeon)
                }
                
                self.isCloseActiveNavigation = true
            }
        }
    }
    
    func remove(_ pigeon: Pigeon) {
        Task { @RealmActor [weak self] in
            guard let self else { return }
            
            await imageManager.removeImage(for: pigeon.id)
            await database.remove(PigeonObject.self, primaryKey: pigeon.id)
            
            await MainActor.run {
                guard let index = self.pigeons.firstIndex(where: { $0.id == pigeon.id }) else { return }
                
                self.pigeons.remove(at: index)
                self.isCloseActiveNavigation = true
            }
        }
    }
}
