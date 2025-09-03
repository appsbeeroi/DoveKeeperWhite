import SwiftUI

struct DirectoryView: View {
    
    @StateObject private var viewModel = DirectoryViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var selectedBreed: PigeonBreed?
    @State private var isShowBreedDetails = false
    @State private var isShowFavorites = false 
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.Images.background)
                    .resize()
                
                VStack(spacing: 8) {
                    navigation
                    pigeons
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 30)
                .padding(.bottom, 100)
                .animation(.easeInOut, value: viewModel.pigeons)
            }
            .onAppear {
                isShowTabBar = true
                viewModel.initPigeons()
            }
            .navigationDestination(isPresented: $isShowBreedDetails) {
                PigeonBreedDetail(pigeon: selectedBreed ?? PigeonBreed()) { pigeon in
                    viewModel.changeLikeStatus(of: pigeon)
                }
            }
            .navigationDestination(isPresented: $isShowFavorites) {
                DirectoryFavoritesView(favoritesPigeons: viewModel.pigeons.filter { $0.isFavorite }) { pigeon in
                    viewModel.changeLikeStatus(of: pigeon)
                }
            }
        }
    }
    
    private var navigation: some View {
        ZStack {
            HStack {
                Button {
                    isShowTabBar = false
                    isShowFavorites = true
                } label: {
                    Image(.Images.Buttons.unlike)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text("Pigeon Guide")
                .font(.quicksand(size: 35, .bold))
                .foregroundStyle(.baseSecondBlack)
        }
        .padding(.horizontal, 35)
    }
    
    private var pigeons: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.pigeons) { breed in
                    PigeonsCellView(pigeon: breed) {
                        viewModel.changeLikeStatus(of: breed)
                    } action: {
                        selectedBreed = breed
                        isShowTabBar = false
                        isShowBreedDetails = true
                    }
                }
            }
            .padding(.horizontal, 35)
        }
    }
}

#Preview {
    NavigationStack {
        DirectoryView(isShowTabBar: .constant(false))
    }
}
