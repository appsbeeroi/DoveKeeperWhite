import SwiftUI

struct AdaptableTextField: View {
    
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        HStack {
            ZStack {
                Text(text == "" ? "Write here..." : text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 20, .bold))
                    .foregroundStyle(text == "" ? .baseLightGray : .baseSecondBlack)
                    .multilineTextAlignment(.leading)
                
                
                TextEditor(text: $text)
                    .opacity(0.02)
                    .focused($isFocused)
            }
            
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
        .padding(.vertical, 20)
        .padding(.horizontal, 12)
        .background(.white)
        .cornerRadius(20)
        .onTapGesture {
            isFocused = true
        }
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

struct MetricsResponse {
    let isOrganic: Bool
    let url: String
    let parameters: [String: String]
}
