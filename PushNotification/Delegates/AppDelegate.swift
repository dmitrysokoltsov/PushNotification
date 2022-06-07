import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requestAuthorization()
        return true
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

