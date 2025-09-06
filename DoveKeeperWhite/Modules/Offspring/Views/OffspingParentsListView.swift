import SwiftUI

struct OffspingParentsListView: View {
    
    @EnvironmentObject var viewModel: OffspingViewModel
    
    @State var pigeon: Pigeon
    
    @State private var parents: [Pigeon] = []
    @State private var isShowDetailView = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .resize()
            
            VStack(spacing: 8) {
                navigation
                content
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 30)
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isShowDetailView) {
            OffspingDetailView(pigeon: pigeon)
        }
        .onChange(of: parents) { parents in
            pigeon.parent = parents
        }
    }
    
    private var navigation: some View {
        HStack {
            BaseBackButton()
            
            Text("Add offsping")
                .font(.quicksand(size: 25, .bold))
                .foregroundStyle(.baseSecondBlack)
                .padding(.horizontal, 35)
            
            Button {
                isShowDetailView = true
            } label: {
                Image(parents.count == 2 ? .Images.Buttons.complete : .Images.Buttons.completeInactive)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
            }
        }
    }
    
    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                Text("Parent")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 20, .bold))
                    .foregroundStyle(.baseSecondBlack)
                
                let parent = viewModel.pigeons.filter { $0.id != pigeon.id }
                
                ForEach(parent) { pigeon in
                    OffspingParentListCellView(pigeon: pigeon, isSelectable: true, parents: $parents)
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 35)
        }
    }
}

#Preview {
    OffspingParentsListView(pigeon: Pigeon(isReal: true))
        .environmentObject(OffspingViewModel())
}

