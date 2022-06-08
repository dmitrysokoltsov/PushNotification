import UIKit
import UserNotifications
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    let fcmToken = "AAAAW0t3scA:APA91bEkWYvdd67fsNwXm8cGGlgNc6dCXejLoOaKPrLvR8NAlAKr6LPssPjW5e7p6_W2goRjrshPgPwCJbsWD_ZtY3Vh9zDyw9c6EwQ4l1shAp-8NeiFaVtDrY2PudCVwjj8cCCn3qsO"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requestAuthorization()
        return true
    }
    
    func messaging(_ messaging: Messaging,
                   didReceiveRegistrationToken fcmToken: String?) {
        print("Received fcmToken: \(String(describing: fcmToken))")
        }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        guard let aps = userInfo[AnyHashable("aps")] as? NSDictionary,
              let alert = aps["alert"] as? NSDictionary,
              let strURL = alert["link_url"] as? String else {
        completionHandler(.failed)
        return }
        
        CoreDataService.shared.saveData(strURL)
        completionHandler(.newData)
        
        print("didReceiveRemoteNotification")
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Coplete \(granted)")
        }
    }
}

