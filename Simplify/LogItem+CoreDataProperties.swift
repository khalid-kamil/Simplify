//
//  LogItem+CoreDataProperties.swift
//  Simplify
//
//  Created by Khalid Kamil on 28/08/2023.
//
//

import Foundation
import CoreData


extension LogItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LogItem> {
        return NSFetchRequest<LogItem>(entityName: "LogItem")
    }

    @NSManaged public var date: Date?
    @NSManaged public var habit: NSObject?

}

extension LogItem : Identifiable {

}
