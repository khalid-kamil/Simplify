
import Foundation
import CoreData
import SwiftUI

class TodayViewModel: ObservableObject {
    @Published var tracker: Tracker
    @Published var today: Date
    @Published var habit: Habit?

    // MARK: New Habit Properties
    @Published var openEditHabit: Bool = false
    @Published var habitTitle: String = ""
    @Published var habitColor: String  = "Blue"
    @Published var habitAllowsNotifications: Bool = false

    // MARK: Editing Existing Habit Data
    @Published var editHabit: Habit?

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
        }
        habit.name = habitTitle
        habit.color = habitColor
        habit.allowsNotifications = habitAllowsNotifications

        if let _ = try? context.save() {
            return true
        }
        return false
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

    init(tracker: Tracker = Tracker.shared) {
        self.tracker = tracker
        self.today = tracker.today
        self.habit = tracker.habit
    }

    var targetAchieved: Bool {
        guard let _ = tracker.habit else { return false }
        return tracker.targetAchieved
    }

    var habitCreated: Bool {
        guard tracker.habit != nil else { return false }
        return true
    }

    var isReminderOn: Bool {
        guard let trackerHabit = tracker.habit else { return false }
        return trackerHabit.allowsNotifications
    }

    var habitName: String {
        guard let trackerHabit = tracker.habit else { return "" }
        return trackerHabit.name!
    }

    var habitIsCompleted: Bool {
        guard let trackerHabit = tracker.habit else { return false }
        return trackerHabit.isCompleted
    }

    var currentStreak: Int {
        guard let _ = tracker.habit else { return 0 }
        return tracker.currentStreak
    }

    var nextMilestone: Int {
        return tracker.milestones[tracker.currentMilestoneIndex]
    }

    func addHabit(name: String) {
        print("Creating Habit...")
        tracker.currentStreak = 0
        tracker.currentMilestoneIndex = 0
        tracker.createHabit(name: name)
        habit = tracker.habit
        print("Habit \(String(describing: habit?.name)) created")
    }

    func toggleReminder() {
        guard let trackerHabit = tracker.habit else { return }
        trackerHabit.allowsNotifications.toggle()
        habit = trackerHabit
    }

    func markHabitAsCompleted() {
        guard let _ = tracker.habit else { return }
        tracker.currentStreak += 1
        tracker.habit?.currentStreak += 1
        tracker.habit?.isCompleted = true
        habit = tracker.habit
    }

    func nextDay() {
        guard let _ = tracker.habit else { return }
        tracker.newDay()
//        habit = tracker.habit
        tracker.today = Calendar.current.date(byAdding: .day, value: 1, to: tracker.today)!
//        today = tracker.today
    }

}
