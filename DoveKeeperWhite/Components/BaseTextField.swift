import SwiftUI

struct BaseTextField: View {
        
    @Binding var text: String
    
    let keyboard: UIKeyboardType
    
    @FocusState.Binding var isFocused: Bool
    
    init(
        text: Binding<String>,
        keyboard: UIKeyboardType = .default,
        isFocused: FocusState<Bool>.Binding
    ) {
        self._text = text
        self.keyboard = keyboard
        self._isFocused = isFocused
    }
    
    var body: some View {
        HStack {
            TextField("", text: $text, prompt: Text("Write here...")
                .foregroundColor(.baseLightGray))
                .font(.quicksand(size: 20, .bold))
                .foregroundStyle(.baseSecondBlack)
                .keyboardType(keyboard)
                .focused($isFocused)
            
            if text != "" {
                Button {
                    text = ""
                    isFocused = false
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.baseLightGray)
                }
            }
        }
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 12)
        .background(.white)
        .cornerRadius(20)
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



enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidResponse
}

class ConfigManager {
    static let shared = ConfigManager()
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    private let defaults: [String: NSObject] = [AppConstants.remoteConfigKey: true as NSNumber]
    
    private init() {
        remoteConfig.setDefaults(defaults)
    }
    
    func fetchConfig(completion: @escaping (Bool) -> Void) {
        if let savedState = UserDefaults.standard.object(forKey: AppConstants.remoteConfigStateKey) as? Bool {
            completion(savedState)
            return
        }
        
        remoteConfig.fetch(withExpirationDuration: 0) { status, error in
            if status == .success {
                self.remoteConfig.activate { _, _ in
                    let isEnabled = self.remoteConfig.configValue(forKey: AppConstants.remoteConfigKey).boolValue
                    UserDefaults.standard.set(isEnabled, forKey: AppConstants.remoteConfigStateKey)
                    completion(isEnabled)
                }
            } else {
                UserDefaults.standard.set(true, forKey: AppConstants.remoteConfigStateKey)
                completion(true)
            }
        }
    }
    
    func getSavedURL() -> URL? {
        guard let urlString = UserDefaults.standard.string(forKey: AppConstants.userDefaultsKey),
              let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
    func saveURL(_ url: URL) {
        UserDefaults.standard.set(url.absoluteString, forKey: AppConstants.userDefaultsKey)
    }
}
