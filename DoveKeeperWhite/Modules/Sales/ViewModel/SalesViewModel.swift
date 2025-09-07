import UIKit

final class SalesViewModel: ObservableObject {
    
    private let database = LocalDatabaseService.shared
    private let imageManager = ImageManager.shared
    
    @Published var isCloseActiveNavigation = false
    
    @Published private(set) var sales: [Sale] = []
    
    private(set) var pigeons: [Pigeon] = []
    
    func loadPigeons() {
        Task { @RealmActor [weak self] in
            guard let self else { return }
            
            let objects: [PigeonObject] = await database.fetchAll()
            
            let result: [Pigeon] = await withTaskGroup(of: Pigeon?.self) { @RealmActor group in
                for object in objects {
                    group.addTask { @RealmActor in
                        guard let image = await self.imageManager.retrieve(fileNamed: object.id.uuidString) else { return nil }
                        var model = Pigeon(from: object, and: image)
                        
                        for parentObject in object.parent {
                            guard let image = await self.imageManager.retrieve(fileNamed: parentObject.id.uuidString) else { return nil }
                            let parentModel = Pigeon(from: parentObject, and: image)
                            
                            model.parent.append(parentModel)
                        }
                        
                        return model
                    }
                }
                
                var pigeons: [Pigeon?] = []
                
                for await pigeon in group {
                    pigeons.append(pigeon)
                }
                
                return pigeons.compactMap { $0 }
            }
            
            await loadSales(from: result)
            
            await MainActor.run {
                self.pigeons = result
            }
        }
    }
    
    func save(_ sale: Sale) {
        Task { @RealmActor [weak self] in
            guard let self else { return }
            
            let object = SaleObject(from: sale)
            
            await database.insert(object)
            
            let pigeonObjects: [PigeonObject] = await database.fetchAll()
            
            for pigeon in sale.pigeons {
                guard let pigeonObject = pigeonObjects.first(where: { $0.id == pigeon.id }) else { return }
                var newPigeon = pigeon
                
                newPigeon.isSold = true
                
                let object = PigeonObject(from: newPigeon, and: pigeonObject.imagePath)
                
                await database.insert(object)
            }
            
            await MainActor.run {
                if let index = self.sales.firstIndex(where: { $0.id == sale.id }) {
                    self.sales[index] = sale
                } else {
                    self.sales.append(sale)
                }
                
                self.isCloseActiveNavigation = true
            }
        }
    }
    
    func remove(_ sale: Sale) {
        Task{ @RealmActor [weak self] in
            guard let self else { return }
            
            await database.remove(SaleObject.self, primaryKey: sale.id)
            
            await MainActor.run {
                if let index = self.sales.firstIndex(where: { $0.id == sale.id }) {
                    self.sales.remove(at: index)
                }
                
                self.isCloseActiveNavigation = true
            }
        }
    }
    
    private func loadSales(from pigeons: [Pigeon]) async {
        Task { @RealmActor in
            let objects: [SaleObject] = await database.fetchAll()
            var sales = objects.map { Sale(from: $0)}
            
            for (saleIndex, sale) in sales.enumerated() {
                for (pigeonIndex, pigeon) in sale.pigeons.enumerated() {
                    guard let targetPigeon = pigeons.first(where: { $0.id == pigeon.id }) else { return }
                    sales[saleIndex].pigeons[pigeonIndex].image = targetPigeon.image
                }
            }
            
            let threadSafeSales = sales
            
            await MainActor.run {
                self.sales = threadSafeSales
            }
        }
    }
}
