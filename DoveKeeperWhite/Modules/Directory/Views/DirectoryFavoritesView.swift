import SwiftUI

struct DirectoryFavoritesView: View {
   
    @Environment(\.dismiss) var dismiss
    
    @State var favoritesPigeons: [PigeonBreed]
    
    let likeAction: (PigeonBreed) -> Void
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .resize()
            
            VStack(spacing: 8) {
                navigation
                
                if favoritesPigeons.isEmpty {
                    stumb
                } else {
                    pigeons
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 30)
            .padding(.bottom, 100)
            .animation(.easeInOut, value: favoritesPigeons)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigation: some View {
        ZStack {
            Text("Favorites")
                .font(.quicksand(size: 35, .bold))
                .foregroundStyle(.baseSecondBlack)
            
            HStack {
                BaseBackButton()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 35)
    }
    
    private var stumb: some View {
        VStack {
            Text("There’s nothing here yet")
                .font(.quicksand(size: 20, .bold))
                .foregroundStyle(.baseSecondBlack)
        }
        .frame(maxHeight: .infinity)
    }
    
    private var pigeons: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(favoritesPigeons) { breed in
                    PigeonsCellView(pigeon: breed) {
                        guard let index = favoritesPigeons.firstIndex(where: { $0.id == breed.id }) else { return }
                        favoritesPigeons.remove(at: index)
                        likeAction(breed)
                    }
                }
            }
            .padding(.horizontal, 35)
        }
    }
}


