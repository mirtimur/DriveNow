import UIKit
import UserNotifications

final class PushNotifications: NSObject {
    static let manager = PushNotifications()
    
    override init() {
        super.init()
        
        addNotifications()
    }
    
    private var authorizationStatus: UNAuthorizationStatus?
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { [weak self] granted, error in
            guard granted,
                  error == nil else { return }
          
            self?.notificationCenter.getNotificationSettings(completionHandler: { settings in
                guard let self else { return }
                
                self.notificationCenter.delegate = self
                self.authorizationStatus = settings.authorizationStatus
            })
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func configureNotifications(
        with title: String,
        body: String,
        timeInterval: TimeInterval,
        identifier: String
    ) {
        guard authorizationStatus == .authorized else { return }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.attachments = []
        content.badge = 1
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: timeInterval,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        
        notificationCenter.add(request,
                               withCompletionHandler: { error in
            guard let error else { return }
            
            print(error.localizedDescription)
        })
    }
    
    func removeNotifications(by identifier: String) {
        notificationCenter.removeDeliveredNotifications(
            withIdentifiers: [identifier]
        )
        notificationCenter.removePendingNotificationRequests(
            withIdentifiers: [identifier]
        )
    }
    
    private func addNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willEnterForegroundNotification(notification:)),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc private func willEnterForegroundNotification(notification: Notification) {
        notificationCenter.setBadgeCount(.zero)
    }
}

extension PushNotifications: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.list, .banner, .sound])
    }
}

