import SwiftUI
import WebKit

struct WebView: View {
    
    let url: URL
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Back") {
                    action()
                }
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .background(.black)
            
            Divider()
            
            WebViewRepresentable(url: url)
        }
    }
}

struct WebViewRepresentable: UIViewRepresentable {
    
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

import SwiftUI
import SwiftUI
import CryptoKit
import WebKit
import AppTrackingTransparency
import UIKit
import FirebaseCore
import FirebaseRemoteConfig
import OneSignalFramework
import AdSupport

struct BlackWindow<RootView: View>: View {
    @StateObject private var viewModel = BlackWindowViewModel()
    private let remoteConfigKey: String
    let rootView: RootView
    
    init(rootView: RootView, remoteConfigKey: String) {
        self.rootView = rootView
        self.remoteConfigKey = remoteConfigKey
    }
    
    var body: some View {
        Group {
            if viewModel.isRemoteConfigFetched && !viewModel.isEnabled && viewModel.isTrackingPermissionResolved && viewModel.isNotificationPermissionResolved {
                rootView
            } else if viewModel.isRemoteConfigFetched && viewModel.isEnabled && viewModel.trackingURL != nil && viewModel.shouldShowWebView {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    PrivacyView(ref: viewModel.trackingURL!)
                }
            } else {
                ZStack {
                    rootView
                }
            }
        }
    }
}
