import SwiftUI

struct SettingsView: View {
    var body: some View {
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
    
    private var navigation: some View {
        Text("Settings")
            .font(.quicksand(size: 35, .bold))
            .foregroundStyle(.baseSecondBlack)
            .padding(.horizontal, 35)
    }
}
