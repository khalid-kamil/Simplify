//
//  LogItem+CoreDataProperties.swift
//  Simplify
//
//  Created by Khalid Kamil on 30/08/2023.
//
//

import Foundation
import CoreData


extension LogItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LogItem> {
        return NSFetchRequest<LogItem>(entityName: "LogItem")
    }

    @NSManaged public var date: Date?
    @NSManaged public var toHabit: Habit?

}

extension LogItem : Identifiable {
    public var wrappedDate: Date {
        date ?? Date()
    }
}
