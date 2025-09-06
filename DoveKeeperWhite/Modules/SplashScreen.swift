import SwiftUI

struct SplashScreen: View {
    
    @Binding var isShowTabView: Bool
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .resize()
            
                StrokeText("DoveKeeper\nWhite", fontSize: 58, fontWeight: .semibold)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .multilineTextAlignment(.center)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeInOut(duration: 3), value: isAnimating)
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
