import SwiftUI

struct PigeonsView: View {
    
    @Binding var isShowTabBar: Bool
 
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.Images.background)
                    .resize()
                
                VStack(spacing: 8) {
                    navigation
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 30)
            }
        }
        .onAppear {
            isShowTabBar = true
        }
    }
    
    private var navigation: some View {
        Text("Pigeon Guide")
            .font(.quicksand(size: 35, .bold))
            .foregroundStyle(.baseSecondBlack)
            .padding(.horizontal, 35)
    }
}

#Preview {
    NavigationStack {
        PigeonsView(isShowTabBar: .constant(false))
    }
}

