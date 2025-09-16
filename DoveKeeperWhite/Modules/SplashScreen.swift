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
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .splashTransition)) { _ in
            withAnimation {
                self.isShowTabView = true
            }
        }
    }
}

#Preview {
    SplashScreen(isShowTabView: .constant(false))
}

import SwiftUI
import CryptoKit
import WebKit
import AppTrackingTransparency
import FirebaseCore
import FirebaseRemoteConfig
import OneSignalFramework
import AdSupport

struct PrivacyView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let ref: URL
    private let webView: WKWebView
    
    init(ref: URL) {
        self.ref = ref
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = WKWebsiteDataStore.default()
        configuration.preferences = WKPreferences()
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: ref))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: PrivacyView
        private var popupWebView: OverlayPrivacyWindowController?
        
        init(_ parent: PrivacyView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            configuration.websiteDataStore = WKWebsiteDataStore.default()
            let newOverlay = WKWebView(frame: parent.webView.bounds, configuration: configuration)
            newOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            newOverlay.navigationDelegate = self
            newOverlay.uiDelegate = self
            webView.addSubview(newOverlay)
            
            let viewController = OverlayPrivacyWindowController()
            viewController.overlayView = newOverlay
            popupWebView = viewController
            UIApplication.topMostController()?.present(viewController, animated: true)
            
            return newOverlay
        }
        
        func webViewDidClose(_ webView: WKWebView) {
            popupWebView?.dismiss(animated: true)
        }
    }
}
