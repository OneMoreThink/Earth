//
//  NotificationCenterManager.swift
//  Earth
//
//  Created by 이종선 on 4/16/24.
//

import Foundation
import CoreData

class NotificationCenterManager {
    
    static let shared = NotificationCenterManager()
    private init(){
        setupNotificationCenter()
    }
    
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contextDidSave(_:)),
            name: .NSManagedObjectContextDidSave,
            object: nil
        )
        NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(contextWillSave(_:)),
                    name: .NSManagedObjectContextWillSave,
                    object: nil
                )

    }

    @objc private func contextDidSave(_ notification: Notification) {
        // Core Data 저장 완료 알림을 받으면 커스텀 알림 발송
        NotificationCenter.default.post(name: .didSaveContext, object: nil, userInfo: notification.userInfo)
    }
    
    @objc private func contextWillSave(_ notification: Notification) {
            guard let context = notification.object as? NSManagedObjectContext else {
                print("No context found in notification")
                return
            }
            
            let deletedObjects = context.deletedObjects
            var userInfo: [AnyHashable: Any] = [:]
            userInfo[NSDeletedObjectsKey] = deletedObjects
            
            // Core Data 저장 시작 알림을 받으면 커스텀 알림 발송
            NotificationCenter.default.post(name: .willSaveContext, object: nil, userInfo: userInfo)
        }
}
