import SwiftUI

struct AppRouteView: View {
    
    @State private var isShowTabView = false
    
    var body: some View {
        if isShowTabView {
            AppTabView()
        } else {
            SplashScreen(isShowTabView: $isShowTabView)
        }
    }
}

