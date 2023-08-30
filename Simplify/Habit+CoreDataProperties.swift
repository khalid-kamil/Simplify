//
//  Habit+CoreDataProperties.swift
//  Simplify
//
//  Created by Khalid Kamil on 30/08/2023.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var name: String?
    @NSManaged public var currentStreak: Int32
    @NSManaged public var currentMilestoneIndex: Int32
    @NSManaged public var isCompleted: Bool
    @NSManaged public var allowsNotifications: Bool
    @NSManaged public var color: String
    @NSManaged public var fromLogItem: NSSet?

}

// MARK: Generated accessors for fromLogItem
extension Habit {

    @objc(addFromLogItemObject:)
    @NSManaged public func addToFromLogItem(_ value: LogItem)

    @objc(removeFromLogItemObject:)
    @NSManaged public func removeFromFromLogItem(_ value: LogItem)

    @objc(addFromLogItem:)
    @NSManaged public func addToFromLogItem(_ values: NSSet)

    @objc(removeFromLogItem:)
    @NSManaged public func removeFromFromLogItem(_ values: NSSet)

}

extension Habit : Identifiable {
    public var wrappedName: String {
        name ?? "N/A"
    }

    public var dateArray: [LogItem] {
        let set = fromLogItem as? Set<LogItem> ?? []
        return set.sorted {
            $0.wrappedDate < $1.wrappedDate
        }
    }
}
