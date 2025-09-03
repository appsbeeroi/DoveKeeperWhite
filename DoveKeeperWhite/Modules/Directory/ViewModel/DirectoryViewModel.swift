import Foundation

final class DirectoryViewModel: ObservableObject {
    
    private let database = LocalDatabaseService.shared
    
    @Published private(set) var pigeons: [PigeonBreed] = []
    
    func changeLikeStatus(of pigeon: PigeonBreed) {
        guard let index = pigeons.firstIndex(where: { $0.id == pigeon.id }) else { return }
        pigeons[index].isFavorite.toggle()
        
        Task { @RealmActor [weak self] in
            guard let self else { return }
            
            let model = pigeons[index]
            let object = PigeonBreedObject(from: model)
            
            await database.insert(object)
        }
    }
    
    func initPigeons() {
        var pigeons = PigeonBreed.allBreeds
        
        Task { @RealmActor [weak self] in
            guard let self else { return }
            
            let objects: [PigeonBreedObject] = await database.fetchAll()
            let favorites = objects.filter { $0.isFavorite }
            
            favorites.forEach { pigeon in
                if let index = pigeons.firstIndex(where: { pigeon.id == $0.uuid }) {
                    pigeons[index].isFavorite = true
                }
            }
            
            let threadSafePigeons = pigeons
            
            await MainActor.run {
                self.pigeons = threadSafePigeons
            }
        }
    }
}
