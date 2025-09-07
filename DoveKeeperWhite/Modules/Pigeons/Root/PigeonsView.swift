import SwiftUI
    
struct PigeonsView: View {
    
    @StateObject private var viewModel = PigeonsViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var pigeonToEdit: Pigeon?
    @State private var isShowAddView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.Images.background)
                    .resize()
                
                VStack(spacing: 8) {
                    navigation
                    
                    if viewModel.pigeons.isEmpty {
                        stumb
                    } else {
                        pigeonsList
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 30)
            }
            .navigationDestination(isPresented: $isShowAddView) {
                AddPigeonView(viewModel: viewModel, pigeon: pigeonToEdit ?? Pigeon(isReal: true))
            }
            .onAppear {
                isShowTabBar = true
                viewModel.loadPigeons()
                pigeonToEdit = nil
            }
            .onChange(of: viewModel.isCloseActiveNavigation) { isClose in
                if isClose {
                    isShowAddView = false
                    viewModel.isCloseActiveNavigation = false
                }
            }
        }
    }
    
    private var navigation: some View {
        Text("Pigeon Guide")
            .font(.quicksand(size: 35, .bold))
            .foregroundStyle(.baseSecondBlack)
            .padding(.horizontal, 35)
    }
    
    private var stumb: some View {
        VStack(spacing: 24) {
            Text("There’s nothing here yet")
                .font(.quicksand(size: 20, .bold))
                .foregroundStyle(.baseSecondBlack)
            
            addButton
        }
        .frame(maxHeight: .infinity)
    }
    
    private var addButton: some View {
        Button {
            isShowTabBar = false
            isShowAddView = true
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 60, height: 60)
                .foregroundStyle(.white)
                .overlay {
                    Image(systemName: "plus")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.baseYellow)
                }
        }
    }
    
    private var pigeonsList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.pigeons) { pigeon in
                        PigeonCellView(pigeon: pigeon) {
                            pigeonToEdit = pigeon
                            isShowTabBar = false
                            isShowAddView = true
                        } editAction: {
                            pigeonToEdit = pigeon
                            isShowTabBar = false
                            isShowAddView = true
                        } removeAction: {
                            viewModel.remove(pigeon)
                        }
                    }
                }
                
                addButton
            }
            .padding(.horizontal, 35)
            
            Color.clear
                .frame(height: 100)
        }
    }
}
    
#Preview {
    NavigationStack {
        PigeonsView(isShowTabBar: .constant(false))
    }
}
