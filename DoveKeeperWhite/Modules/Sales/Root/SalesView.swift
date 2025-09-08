import SwiftUI

struct SalesView: View {
    
    @StateObject private var viewModel = SalesViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var saleToEdit: Sale?
    @State private var selectedSalesPeriod: SalesPeriod = .month
    @State private var isShowAddSaleListView = false
    @State private var isShowDetailView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.Images.background)
                    .resize()
                
                VStack(spacing: 8) {
                    navigation
                    content
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 30)
                .animation(.easeInOut, value: viewModel.sales)
            }
            .navigationDestination(isPresented: $isShowAddSaleListView) {
                AddSalesListView(sale: saleToEdit ?? Sale(isReal: true))
            }
            .navigationDestination(isPresented: $isShowDetailView) {
                SaleDetailView(sale: saleToEdit ?? Sale(isReal: true))
            }
            .onAppear {
                viewModel.loadPigeons()
                isShowTabBar = true
                saleToEdit = nil
            }
            .onChange(of: viewModel.isCloseActiveNavigation) { isClose in
                if isClose {
                    isShowDetailView = false
                    isShowAddSaleListView = false
                    viewModel.isCloseActiveNavigation = false
                }
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigation: some View {
        Text("Sales")
            .font(.quicksand(size: 35, .bold))
            .foregroundStyle(.baseSecondBlack)
            .padding(.horizontal, 35)
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.sales.isEmpty {
            stumb
        } else {
            sales
        }
    }
    
    private var stumb: some View {
        VStack(spacing: 24) {
            Text("There’s nothing here yet")
                .font(.quicksand(size: 20, .bold))
                .foregroundStyle(.baseSecondBlack)
            
            if !viewModel.pigeons.filter({ !$0.isSold }).isEmpty {
                addButton
            }
        }
        .frame(maxHeight: .infinity)
        .padding(.bottom, viewModel.pigeons.filter({ !$0.isSold }).isEmpty ? 80 : 0)
    }
    
    private var addButton: some View {
        Button {
            isShowTabBar = false
            isShowAddSaleListView = true
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
    
    private var sales: some View {
        VStack(spacing: 24) {
            salesPeriodPicker
            salesList
        }
        .padding(.horizontal, 35)
        .padding(.bottom, UIScreen.isSe ? 50 : 100)
    }
    
    private var salesPeriodPicker: some View {
        VStack(spacing: 8) {
            HStack(spacing: 6) {
                ForEach(SalesPeriod.allCases) { period in
                    Button {
                        selectedSalesPeriod = period
                    } label: {
                        Text(period.title)
                            .frame(height: 40)
                            .padding(.horizontal, 10)
                            .font(.quicksand(size: 18, .bold))
                            .foregroundStyle(.baseSecondBlack)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay {
                                if selectedSalesPeriod == period {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.baseYellow, lineWidth: 3)
                                }
                            }
                    }
                }
            }
            
            VStack(spacing: 12) {
                Text("Number of pigeons sold")
                    .font(.quicksand(size: 16, .bold))
                    .foregroundStyle(.baseGray)
                
                let selectedPeriodAgo = Calendar.current.date(byAdding: selectedSalesPeriod == .month ? .month : .year, value: -1, to: Date()) ?? Date()
                let allSales = viewModel.sales.filter { $0.date >= selectedPeriodAgo }
                
                Text(allSales.flatMap { $0.pigeons }.count.formatted())
                    .font(.quicksand(size: 50, .bold))
                    .foregroundStyle(.baseSecondBlack)
            }
            .frame(maxWidth: .infinity)
            .padding(18)
            .background(.white)
            .cornerRadius(18)
        }
    }
    
    private var salesList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                let selectedPeriodAgo = Calendar.current.date(byAdding: selectedSalesPeriod == .month ? .month : .year, value: -1, to: Date()) ?? Date()
                let allSales = viewModel.sales.filter { $0.date >= selectedPeriodAgo }
                
                ForEach(allSales) { sale in
                    SaleCellView(sale: sale) {
                        saleToEdit = sale
                        isShowTabBar = false
                        
                        let unsoldPigeon = viewModel.pigeons.filter { $0.isSold == false }
                        
                        if unsoldPigeon.isEmpty {
                            isShowDetailView = true
                        } else {
                            isShowAddSaleListView = true
                        }
                    } editAction: {
                        saleToEdit = sale
                        isShowTabBar = false
                        isShowDetailView = true
                    } removeAction: {
                        viewModel.remove(sale)
                    }
                }
            }
            
            if !viewModel.pigeons.filter({ !$0.isSold }).isEmpty {
                addButton
            }
        }
    }
}

#Preview {
    SalesView(isShowTabBar: .constant(false))
}
