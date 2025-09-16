import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.dismiss) var dismiss
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
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



class PermissionManager {
    static let shared = PermissionManager()
    
    private var hasRequestedTracking = false
    
    private init() {}
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        OneSignal.Notifications.requestPermission({ accepted in
            DispatchQueue.main.async {
                completion(accepted)
            }
        }, fallbackToSettings: false)
    }
    
    func requestTrackingAuthorization(completion: @escaping (String?) -> Void) {
        if #available(iOS 14, *) {
            func checkAndRequest() {
                let status = ATTrackingManager.trackingAuthorizationStatus
                switch status {
                case .notDetermined:
                    ATTrackingManager.requestTrackingAuthorization { newStatus in
                        DispatchQueue.main.async {
                            if newStatus == .notDetermined {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    checkAndRequest()
                                }
                            } else {
                                self.hasRequestedTracking = true
                                let idfa = newStatus == .authorized ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : nil
                                completion(idfa)
                            }
                        }
                    }
                default:
                    DispatchQueue.main.async {
                        self.hasRequestedTracking = true
                        let idfa = status == .authorized ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : nil
                        completion(idfa)
                    }
                }
            }
            
            DispatchQueue.main.async {
                checkAndRequest()
            }
        } else {
            DispatchQueue.main.async {
                self.hasRequestedTracking = true
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                completion(idfa)
            }
        }
    }
}
