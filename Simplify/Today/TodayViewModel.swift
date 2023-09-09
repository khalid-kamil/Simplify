
import Foundation
import CoreData
import SwiftUI

class TodayViewModel: ObservableObject {
    @Published var today: Date = Calendar.current.startOfDay(for: Date())

    // MARK: View Model Properties
    let habitTarget: Int = 28
    let habitMilestones: [Int] = [1, 2, 3, 5, 7, 10, 14, 21, 28]

    // MARK: New Habit Properties
    @Published var openEditHabit: Bool = false
    @Published var habitTitle: String = ""
    @Published var habitColor: String  = "Blue"
    @Published var habitAllowsNotifications: Bool = false

    // MARK: Editing Existing Habit Data
    @Published var editHabit: Habit?

    // MARK: Current Login Item
    @Published var currentLogItem: LogItem?
    var logItemPredicate: NSPredicate {
        NSPredicate(format: "date == %@", today as CVarArg)
    }

    // MARK: Adding Habit to CoreData
    func addHabit(context: NSManagedObjectContext) -> Bool {
        // MARK: Updating existing data in CoreData
        var habit: Habit
        if let editHabit = editHabit {
            habit = editHabit
        } else {
            habit = Habit(context: context)
            habit.creationDate = Date()
            habit.isCompleted = false
            habit.currentStreak = 0
            habit.currentMilestoneIndex = 0
        }
        habit.name = habitTitle
        habit.color = habitColor
        habit.allowsNotifications = habitAllowsNotifications
        if let logItem = currentLogItem {
            habit.addToFromLogItem(logItem)
        }

        if let _ = try? context.save() {
            return true
        }
        return false
    }

    // MARK: Load today's LogItem
    func loadLogItem(from items: FetchedResults<LogItem>, in context: NSManagedObjectContext) {
        print("Today: \(today.formatted(date: .complete, time: .complete))")
        let calendar = Calendar.current
        if items.isEmpty {
            let startDate = today
            let logDays = calendar.numberOfDaysToGenerate(from: startDate)
            for day in (0...logDays) {
                let logItem = LogItem(context: context)
                logItem.date = calendar.date(byAdding: .day, value: day, to: startDate)
                if day == 0 {
                    currentLogItem = logItem
                }
            }
            try? context.save()
        } else {
            currentLogItem = items.first
        }
        print(currentLogItem?.date?.formatted(date: .complete, time: .complete) ?? "LogItem not found")
    }

    // MARK: Adding LogItems to CoreData
    func createLogItems() {

    }

    // MARK: Resetting View Model Habit Data
    func resetHabitData() {
        habitTitle = ""
        habitColor = "Blue"
        habitAllowsNotifications = false
    }

    // MARK: Check that only one habit was fetched
    func habitFound(in habits: FetchedResults<Habit>) -> Bool {
        return !habits.isEmpty
    }

    // MARK: If Habit to edit is available then set the existing data to it
    func setupEditHabit() {
        if let editHabit = editHabit {
            habitTitle = editHabit.name ?? ""
            habitColor = editHabit.color
            habitAllowsNotifications = editHabit.allowsNotifications
        }
    }

    // MARK: Mark Habit as completed
    func markHabitAsCompleted(_ habit: Habit, in context: NSManagedObjectContext) {
//        habit.isCompleted = true
        currentLogItem?.toHabit = habit
        if habit.currentStreak == habitMilestones[Int(habit.currentMilestoneIndex)] && habit.currentMilestoneIndex + 1 < habitMilestones.count {
            habit.currentMilestoneIndex += 1
        }
        habit.currentStreak += 1
        print("Current Milestone Index: \(habit.currentMilestoneIndex)")

        try? context.save()
    }
}

extension Calendar {
    func numberOfDaysToGenerate(from date: Date) -> Int {
        let startDate = startOfDay(for: date)
        let futureDate = Calendar.current.date(byAdding: .day, value: 10, to: startDate)!
        let endDate = startOfDay(for: futureDate)
        let numberOfDays = dateComponents([.day], from: startDate, to: endDate)
        return numberOfDays.day!
    }
}

extension Date {
    var startDateOfMonth: Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else {
            print("Unable to get start date from date")
            return nil
        }
        return date
    }

    var endDateOfMonth: Date? {
        guard let date = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startDateOfMonth!) else {
            print("Unable to get end date from date")
            return nil
        }
        return date
    }
}
