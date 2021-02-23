//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
#if !os(watchOS)
import Photos
#endif
import UserNotifications

/*
 
 <key>NSMicrophoneUsageDescription</key>
 <string>Need microphone access for uploading videos</string>
 
 <key>NSCameraUsageDescription</key>
 <string>Need camera access for uploading Images</string>
 
 <key>NSLocationUsageDescription</key>
 <string>Need location access for updating nearby friends</string>
 
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>This app will use your location to show cool stuffs near you.</string>
 
 <key>NSPhotoLibraryUsageDescription</key>
 <string>Need Library access for uploading Images</string>
 
 */

extension RJSLib {
    public struct PermissionsManager {
        
        private init() {}
        
        private static let _notGranted: String = "Not granted"

        @available(*, deprecated)
        public static func checkPushNotificationsPermission(completetion:@escaping (Bool, String?) -> Void) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                guard granted else {
                    RJS_Logs.debug(_notGranted, tag: .rjsLib)
                    completetion(true, nil)
                    return
                }
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    completetion(true, "\(settings)")
                }
            }
        }

        #if !os(macOS)
        @available(*, deprecated)
        public static func checkAudioPermission(completetion:@escaping (Bool) -> Void) {
            let audioSession = AVAudioSession.sharedInstance()
            if audioSession.responds(to: #selector(AVAudioSession.requestRecordPermission(_:))) {
                audioSession.requestRecordPermission({(granted: Bool) -> Void in
                    if granted {
                        completetion(true)
                    } else {
                        RJS_Logs.debug(_notGranted, tag: .rjsLib)
                        completetion(false)
                    }
                })
            }
        }
        #endif
        
        @available(*, deprecated)
        public static func checkPhotoLibrary(completetion:@escaping (Bool?) -> Void) {
            let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
            switch photoAuthorizationStatus {
            case .authorized:
                completetion(true)
            case .notDetermined:
                RJS_Logs.debug("Asking permission", tag: .rjsLib)
                completetion(nil)
                PHPhotoLibrary.requestAuthorization({ (newStatus) in
                    if newStatus ==  PHAuthorizationStatus.authorized {
                        completetion(true)
                    } else {
                        RJS_Logs.debug(_notGranted, tag: .rjsLib)
                        completetion(false)
                    }
                })
            case .restricted:
                RJS_Logs.info("\(_notGranted) : User do not have access to photo album.", tag: .rjsLib)
                completetion(false)
            case .denied:
                RJS_Logs.info("\(_notGranted) : User has denied the permission.", tag: .rjsLib)
                completetion(false)
            //case .limited:
            //    RJS_Logs.info("\(_notGranted) : User limited the permission.")
            //    completetion(false)
            @unknown default:
                RJS_Logs.info("Unknown.", tag: .rjsLib)
                completetion(false)
            }
        }
    }
}
