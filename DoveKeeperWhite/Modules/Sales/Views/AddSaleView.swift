import SwiftUI

struct AddSaleView: View {
    
    @EnvironmentObject var viewModel: SalesViewModel
    
    @State var sale: Sale
    
    @State private var isShowDetailView = false
    
    @FocusState private var isFocused: Bool
    
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
            .padding(.horizontal, 35)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Button("Done") {
                            isFocused = false
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
         }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isShowDetailView) {
            SaleDetailView(sale: sale)
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
                Image(sale.isUnlock ? .Images.Buttons.complete : .Images.Buttons.completeInactive)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
            }
        }
    }
    
    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                datePicker
                price
            }
            .padding(.top, 24)
        }
    }
    
    private var datePicker: some View {
        VStack(spacing: 2) {
            Text("Sale date")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 15, .bold))
                .foregroundStyle(.baseGray)
            
            DatePicker("", selection: $sale.date,  in: ...Date(), displayedComponents: [.date])
                .labelsHidden()
                .datePickerStyle(.wheel)
        }
        .padding()
        .background(.white)
        .cornerRadius(18)
    }
    
    private var price: some View {
        VStack(spacing: 2) {
            Text("Price")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 15, .bold))
                .foregroundStyle(.baseGray)
            
            BaseTextField(text: $sale.price, keyboard: .numberPad, isFocused: $isFocused)
        }
    }
}
