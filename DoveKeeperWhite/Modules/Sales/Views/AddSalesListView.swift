import SwiftUI

struct AddSalesListView: View {
    
    @EnvironmentObject var viewModel: SalesViewModel
    
    @State var sale: Sale
    
    @State private var selectedPigeons: [Pigeon] = []
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
            AddSaleView(sale: sale)
        }
        .onAppear {
            selectedPigeons = sale.pigeons
        }
        .onChange(of: selectedPigeons) { pigeons in
            sale.pigeons = pigeons
        }
    }
    
    private var navigation: some View {
        HStack {
            BaseBackButton()
            
            Text("Add sale")
                .frame(maxWidth: .infinity)
                .font(.quicksand(size: 25, .bold))
                .foregroundStyle(.baseSecondBlack)
            
            Button {
                isShowDetailView = true
            } label: {
                Image(sale.pigeons.isEmpty ? .Images.Buttons.completeInactive : .Images.Buttons.complete)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
            }
            .disabled(sale.pigeons.isEmpty)
        }
        .padding(.horizontal, 35)
    }
    
    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                Text("Pigeons")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 20, .bold))
                    .foregroundStyle(.baseSecondBlack)
                
                ForEach(viewModel.pigeons.filter { !$0.isSold }) { pigeon in
                    OffspingParentListCellView(pigeon: pigeon, isSelectable: true, isDisable: false, parents: $selectedPigeons)
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 35)
        }
    }
}
