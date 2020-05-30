//
//  AppDelegate.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let center = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.tintColor = UIColor(named: "main")
        center.delegate = self
        
        center.getNotificationSettings { [weak self] (settings) in
            guard let self = self else {return}
            switch settings.authorizationStatus {
            case .notDetermined:
                let option: UNAuthorizationOptions = [.alert, .carPlay, .sound, .badge]
                self.center.requestAuthorization(options: option) { (success, error) in
                    print(success)
                }
            case .denied, .authorized, .provisional:
                break
            }
        }
        
        let confirmAction = UNNotificationAction(identifier: "Confirm", title: "Já estudei 👍", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "Cancel", title: "Cancelar", options: [])
        let category = UNNotificationCategory(identifier: "Lembrete", actions: [cancelAction, confirmAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: [.customDismissAction])
        center.setNotificationCategories([category])
        
        return true
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "Confirm":
            print("Usuário confirmou")
            
            let id = response.notification.request.identifier
            StudyManager.shared.setPlanDone(id: id)
            NotificationCenter.default.post(name: NSNotification.Name("confirmed"), object: nil, userInfo: ["id": id])
            
        case "Cancel":
            print("Usuário cancelou")
        case UNNotificationDefaultActionIdentifier:
            print("Tocou na própria notificação")
        case UNNotificationDismissActionIdentifier:
            print("Usuário dismissou a notificação")
        default:
            break
        }
        
        completionHandler()
    }
}
