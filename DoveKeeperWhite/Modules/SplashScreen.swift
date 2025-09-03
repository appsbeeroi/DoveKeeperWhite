import SwiftUI

struct SplashScreen: View {
    
    @Binding var isShowTabView: Bool
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .resize()
            
            if isAnimating {
                StrokeText("DoveKeeper\nWhite", fontSize: 58, fontWeight: .semibold)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .multilineTextAlignment(.center)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isAnimating = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isShowTabView = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen(isShowTabView: .constant(false))
}
