import SwiftUI

struct OffspringView: View {
    
    @StateObject private var viewModel = OffspingViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var pigeonToEdit: Pigeon?
    @State private var isShowAddOffspingView = false
    @State private var isShowDetailView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.Images.background)
                    .resize()
                
                VStack(spacing: 8) {
                    navigation
                    
                    let filteredPigeons = viewModel.pigeons.filter { $0.status == .young && $0.birthDate != nil }
                    
                    if filteredPigeons.isEmpty {
                        stumb
                    } else {
                        pigeonsList
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 30)
            }
            .navigationDestination(isPresented: $isShowAddOffspingView) {
                AddOffspingView(pigeon: pigeonToEdit ?? Pigeon(isReal: true))
            }
            .navigationDestination(isPresented: $isShowDetailView) {
                OffspingDetailView(pigeon: pigeonToEdit ?? Pigeon(isReal: true))
            }
            .onAppear {
                viewModel.loadPigeons()
                isShowTabBar = true
                pigeonToEdit = nil 
            }
            .onChange(of: viewModel.isCloseActiveNavigation) { isClose in
                if isClose {
                    isShowAddOffspingView = false
                    isShowDetailView = false
                    viewModel.isCloseActiveNavigation = false
                }
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigation: some View {
        Text("Procreation\nrecord")
            .font(.quicksand(size: 35, .bold))
            .foregroundStyle(.baseSecondBlack)
            .padding(.horizontal, 35)
            .multilineTextAlignment(.center)
    }
    
    private var stumb: some View {
        VStack(spacing: 24) {
            Text("There’s nothing here yet")
                .font(.quicksand(size: 20, .bold))
                .foregroundStyle(.baseSecondBlack)
            
            addButton
        }
        .frame(maxHeight: .infinity)
        .padding(.bottom, 40)
    }
    
    private var addButton: some View {
        Button {
            isShowTabBar = false
            isShowAddOffspingView = true
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
            LazyVStack(spacing: 12) {
                let filteredPigeons = viewModel.pigeons.filter { $0.status == .young && $0.birthDate != nil }

                ForEach(filteredPigeons) { pigeon in
                    OffspingPigeonCellView(pigeon: pigeon) {
                        pigeonToEdit = pigeon
                        isShowTabBar = false
                        isShowDetailView = true
                    } editAction: {
                        pigeonToEdit = pigeon
                        isShowTabBar = false
                        isShowAddOffspingView = true
                    } removeAction: {
                        viewModel.remove(pigeon)
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
    OffspringView(isShowTabBar: .constant(false))
}

