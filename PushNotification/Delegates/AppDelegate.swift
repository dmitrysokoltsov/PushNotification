import UIKit
import UserNotifications
import FirebaseMessaging
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        application.registerForRemoteNotifications()
        requestAuthorization()
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            print("TOKEN:\(token)")
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("back")
        updateImageFromNotification(didReceive: response)
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        guard let aps = userInfo[AnyHashable("aps")] as? NSDictionary,
              let alert = aps["alert"] as? NSDictionary,
              let strURL = alert["link_url"] as? String else { return }
        
        CoreDataService.shared.saveData(strURL)
        completionHandler(.newData)
    }
    
    // MARK: UISceneSession Lifecycle
    
    func requestAuthorization() {
        let notificationCenter = UNUserNotificationCenter.current()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Coplete \(granted)")
        }
    }
    
    func updateImageFromNotification(didReceive response: UNNotificationResponse) {
        let userInfo = response.notification.request.content.userInfo
        guard let aps = userInfo[AnyHashable("aps")] as? NSDictionary,
              let alert = aps["alert"] as? NSDictionary,
              let strURL = alert["link_url"] as? String else { return }
        
        CoreDataService.shared.saveData(strURL)
        print("didReceiveRemoteNotification")
    }
}

