//
//  Task+CoreDataProperties.swift
//  LifeNerd
//
//  Created by Eric Torigian on 8/3/20.
//  Copyright © 2020 Torigian Group, LLC. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var taskName: String?

}
