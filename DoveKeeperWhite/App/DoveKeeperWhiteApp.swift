import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    private var lastPermissionCheck: Date?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        PushScheduler.shared.requestPermission()
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        OneSignal.initialize(AppConstants.oneSignalAppID, withLaunchOptions: launchOptions)
        
        UNUserNotificationCenter.current().delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTrackingAction),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        return true
    }
    
    @objc private func handleTrackingAction() {
        if UIApplication.shared.applicationState == .active {
            let now = Date()
            if let last = lastPermissionCheck, now.timeIntervalSince(last) < 2 {
                return
            }
            lastPermissionCheck = now
            NotificationCenter.default.post(name: .checkTrackingPermission, object: nil)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
}

@main
struct DoveKeeperWhiteApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            BlackWindow(rootView: AppRouteView(), remoteConfigKey: AppConstants.remoteConfigKey)
        }
    }
}

struct AppConstants {
    static let metricsBaseURL = "https://vekeepww.com/app/metrics"
    static let salt = "wzSjLN5hUc6GmFN0y51qJ5HrN9gzkSLM"
    static let oneSignalAppID = "d8f018aa-062e-4e85-8a31-a396022289d3"
    static let userDefaultsKey = "dove"
    static let remoteConfigStateKey = "doveKeeper"
    static let remoteConfigKey = "hasValue"
}

import SwiftUI
import CryptoKit
import WebKit
import AppTrackingTransparency
import FirebaseCore
import FirebaseRemoteConfig
import OneSignalFramework
import AdSupport


