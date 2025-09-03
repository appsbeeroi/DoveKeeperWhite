import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isNotificationSetup") var isNotificationSetup = false
    
    @Binding var isShowTabBar: Bool
    
    @State private var selectedSettingsType: SettingsCellType?
    @State private var removedHistoryType: SettingsHistoryType?
    
    @State private var isShowRemoveAlert = false
    @State private var isNotificationEnable = false
    @State private var isShowClearView = false
    @State private var isNotificationToggleSwitchedOn = false
    @State private var isShowNotificationAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .resize()
            
            VStack(spacing: 18) {
                navigation
                
                VStack(spacing: 24) {
                    settings
                    history
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 30)
            .padding(.horizontal, 35)
            
            if let selectedSettingsType,
               let url = URL(string: selectedSettingsType.urlString) {
                WebView(url: url) {
                    self.selectedSettingsType = nil
                    self.isShowTabBar = true
                }
            }
        }
        .onAppear {
            isNotificationToggleSwitchedOn = isNotificationSetup
        }
        .alert("Are you sure, you want to remove \(removedHistoryType?.title ?? "")", isPresented: $isShowRemoveAlert) {
            Button("Yes", role: .destructive) {
                isShowClearView = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isShowClearView = false
                }
            }
        }
        .alert("User notification permission is required. Open settings?", isPresented: $isShowNotificationAlert) {
            Button("Yes") {
                openAppSettings()
            }
            
            Button("Cancel") {}
        }
        .onChange(of: isNotificationToggleSwitchedOn) { isOn in
            Task {
                if isOn {
                    switch await PushScheduler.shared.permissionStatus {
                        case .authorized:
                            isNotificationSetup = true
                        default:
                            isNotificationToggleSwitchedOn = false
                            isShowNotificationAlert = true
                    }
                } else {
                    isNotificationSetup = false
                    PushScheduler.shared.cancelAllScheduled()
                }
            }
        }
    }
    
    private var navigation: some View {
        Text("Settings")
            .font(.quicksand(size: 35, .bold))
            .foregroundStyle(.baseSecondBlack)
            .padding(.horizontal, 35)
    }
    
    private var settings: some View {
        VStack(spacing: 8) {
            ForEach(SettingsCellType.allCases) { type in
                SettingsCellView(type: type, isNotificationEnable: $isNotificationToggleSwitchedOn) {
                    isShowTabBar = false
                    selectedSettingsType = type
                }
            }
        }
    }
    
    private var history: some View {
        VStack(spacing: 8) {
            Text("Clean up history")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.black)
            
            ForEach(SettingsHistoryType.allCases) { type in
                SettingsHistoryCellView(type: type, removedType: removedHistoryType, isShowClearView: isShowClearView) {
                    removedHistoryType = type
                    isShowRemoveAlert = true
                }
            }
        }
    }
    
    private func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
}

#Preview {
    SettingsView(isShowTabBar: .constant(false))
}

