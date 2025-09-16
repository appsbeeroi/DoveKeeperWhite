import SwiftUI

struct StrokeText: View {
    
    let text: String
    let fontSize: CGFloat
    let fontWeight: QuicksandFontWeight
    let mainColor: Color?
    let backColor: Color?
    
    init(
        _ text: String,
        fontSize: CGFloat,
        fontWeight: QuicksandFontWeight = .bold,
        mainColor: Color? = nil,
        backColor: Color? = nil
    ) {
        self.text = text
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.mainColor = mainColor
        self.backColor = backColor
    }
    
    var body: some View {
        ZStack {
            Group {
                Text(text).offset(x: -2, y: -2)
                Text(text).offset(x: 0, y: -2)
                Text(text).offset(x: 2, y: -2)
                Text(text).offset(x: -2, y: 0)
                Text(text).offset(x: 2, y: 0)
                Text(text).offset(x: -2, y: 2)
                Text(text).offset(x: 0, y: 2)
                Text(text).offset(x: 2, y: 2)
            }
            .font(.quicksand(size: fontSize, fontWeight))
            .foregroundStyle(backColor ?? .baseBrown)
            
            Text(text)
                .font(.quicksand(size: fontSize, fontWeight))
                .foregroundStyle(mainColor ?? .baseDarkRed)
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



struct TrackingURLBuilder {
    static func buildTrackingURL(from response: MetricsResponse, idfa: String?, bundleID: String) -> URL? {
        let onesignalId = OneSignal.User.onesignalId
        
        if response.isOrganic {
            guard var components = URLComponents(string: response.url) else {
                return nil
            }
            
            var queryItems: [URLQueryItem] = components.queryItems ?? []
            if let idfa = idfa {
                queryItems.append(URLQueryItem(name: "idfa", value: idfa))
            }
            queryItems.append(URLQueryItem(name: "bundle", value: bundleID))
            
            if let onesignalId = onesignalId {
                queryItems.append(URLQueryItem(name: "onesignal_id", value: onesignalId))
            } else {
                print("OneSignal ID not available for organic URL")
            }
            
            components.queryItems = queryItems.isEmpty ? nil : queryItems
            
            guard let url = components.url else {
                return nil
            }
            print(url)
            return url
        } else {
            let subId2 = response.parameters["sub_id_2"]
            let baseURLString = subId2 != nil ? "\(response.url)/\(subId2!)" : response.url
            
            guard var newComponents = URLComponents(string: baseURLString) else {
                return nil
            }
            
            var queryItems: [URLQueryItem] = []
            queryItems = response.parameters
                .filter { $0.key != "sub_id_2" }
                .map { URLQueryItem(name: $0.key, value: $0.value) }
            queryItems.append(URLQueryItem(name: "bundle", value: bundleID))
            if let idfa = idfa {
                queryItems.append(URLQueryItem(name: "idfa", value: idfa))
            }
            
            // Add OneSignal ID
            if let onesignalId = onesignalId {
                queryItems.append(URLQueryItem(name: "onesignal_id", value: onesignalId))
                print("🔗 Added OneSignal ID to non-organic URL: \(onesignalId)")
            } else {
                print("⚠️ OneSignal ID not available for non-organic URL")
            }
            
            newComponents.queryItems = queryItems.isEmpty ? nil : queryItems
            
            guard let finalURL = newComponents.url else {
                return nil
            }
            print(finalURL)
            return finalURL
        }
    }
}
