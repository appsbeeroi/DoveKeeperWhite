import SwiftUI

struct AppTabView: View {
    
    @State private var selection: AppTabViewState = .directory
    @State private var isShowTabBar = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                DirectoryView(isShowTabBar: $isShowTabBar)
                    .tag(AppTabViewState.directory)
                
                PigeonsView(isShowTabBar: $isShowTabBar)
                    .tag(AppTabViewState.pigeons)
                
                OffspringView(isShowTabBar: $isShowTabBar)
                    .tag(AppTabViewState.offspring)
                
                SalesView()
                    .tag(AppTabViewState.sales)
                
                SettingsView(isShowTabBar: $isShowTabBar)
                    .tag(AppTabViewState.settings)
            }
            
            VStack {
                tabBar
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
    }
    
    private var tabBar: some View {
        HStack {
            ForEach(AppTabViewState.allCases) { state in
                Button {
                    selection = state
                } label: {
                    VStack(spacing: 8) {
                        Image(state.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                        
                        VStack(spacing: 8) {
                            Text(state.title)
                                .font(.quicksand(size: 11, .bold))
                                .foregroundStyle(.baseSecondBlack)
                                .lineLimit(1)
                        
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(selection == state ? .baseYellow : .clear)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 12)
        .padding(.horizontal)
        .padding(.bottom, 50)
        .background(.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .opacity(isShowTabBar ? 1 : 0)
        .animation(.easeInOut, value: isShowTabBar)
    }
}

#Preview {
    AppTabView()
}


