//
//  PostEntity+CoreDataProperties.swift
//  Earth
//
//  Created by 이종선 on 4/14/24.
//
//

import Foundation
import CoreData


extension PostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostEntity> {
        return NSFetchRequest<PostEntity>(entityName: "PostEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var videoUrl: String
    @NSManaged public var createdAt: Date

}

extension PostEntity : Identifiable {

}
