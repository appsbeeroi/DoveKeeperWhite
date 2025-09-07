import SwiftUI

struct SaleDetailView: View {
    
    @EnvironmentObject var viewModel: SalesViewModel
    
    let sale: Sale
    
    @State private var isShowRemoveAlert = false
    
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
        .alert("Are you sure you want to delete this pigeon?", isPresented: $isShowRemoveAlert) {
            Button("Remove", role: .destructive) {
                viewModel.remove(sale)
            }
        }
    }
    
    private var navigation: some View {
        HStack {
            BaseBackButton()
            
            Spacer()
            
            HStack(spacing: 8) {
                Button {
                    viewModel.save(sale)
                } label: {
                    Image(.Images.Buttons.complete)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .cornerRadius(10)
                }
            }
            
            Button {
                isShowRemoveAlert.toggle()
            } label: {
                Image(systemName: "trash")
                    .frame(width: 44, height: 44)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.red)
                    .background(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 35)
    }
    
    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                saleInfo
            }
            .padding(.top, 48)
            .padding(.horizontal, 35)
        }
    }
    
    private var saleInfo: some View {
        VStack(spacing: 12) {
            Text(sale.date.formatted(.dateTime.year().month(.twoDigits).day()))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 20, .bold))
                .foregroundStyle(.baseSecondBlack)
            
            HStack {
                Text("Price")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 16, .bold))
                    .foregroundStyle(.baseGray)
                
                Text("\(sale.price) $")
                    .font(.quicksand(size: 50, .bold))
                    .foregroundStyle(.baseSecondBlack)
            }
            
            LazyVStack(spacing: 8) {
                Text("List of pigeons sold")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 20, .bold))
                    .foregroundStyle(.baseSecondBlack)
                
                ForEach(sale.pigeons) { pigeon in
                    OffspingParentListCellView(pigeon: pigeon, isSelectable: false, isDisable: false, parents: .constant([]))
                }
            }
        }
    }
}
