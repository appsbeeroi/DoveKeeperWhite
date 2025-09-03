import UserNotifications
import UIKit

final class PushScheduler {
    
    static let shared = PushScheduler()

    private let center = UNUserNotificationCenter.current()

    private init() {}

    private let calendar: Calendar = {
        var cal = Calendar.current
        cal.timeZone = .current
        return cal
    }()

    private func timeComponents(from date: Date) -> DateComponents {
        var comp = calendar.dateComponents([.hour, .minute], from: date)
        comp.timeZone = .current
        return comp
    }
}

// MARK: - Public API
extension PushScheduler {
    
    var permissionStatus: UNAuthorizationStatus {
        get async {
            let settings = await center.notificationSettings()
            return settings.authorizationStatus
        }
    }
    
    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error {
                print("❌ Notification permission request failed: \(error)")
                return
            }
            print(granted ? "✅ Notification permission granted" : "🚫 Notification permission denied")
        }
    }
    
    func scheduleDaily(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Time to play!"
        content.body = "Joker is waiting — let's go!"
        content.sound = .default
        
        let components = timeComponents(from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        center.add(request) { error in
            if let error {
                print("❌ Failed to schedule daily notification: \(error)")
            } else {
                let hh = components.hour ?? 0
                let mm = components.minute ?? 0
                print("✅ Daily notification scheduled for \(String(format: "%02d:%02d", hh, mm))")
            }
        }
    }
    
    func cancelAllScheduled() {
        center.removeAllPendingNotificationRequests()
        print("🧹 Cleared all scheduled notifications")
    }
}
