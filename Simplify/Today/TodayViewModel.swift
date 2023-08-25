
import Foundation

class TodayViewModel: ObservableObject {
    @Published var tracker: Tracker
    @Published var today: Date
    @Published var habit: Habit?

    init(tracker: Tracker = Tracker.shared) {
        self.tracker = tracker
        self.today = tracker.today
        self.habit = tracker.habit
    }

    var targetAchieved: Bool {
        guard let habit = tracker.habit else { return false }
        return habit.targetAchieved
    }

    var habitCreated: Bool {
        guard let _ = tracker.habit else { return false }
        return true
    }

    var isReminderOn: Bool {
        guard let trackerHabit = tracker.habit else { return false }
        return trackerHabit.isReminderOn
    }

    var habitName: String {
        guard let trackerHabit = tracker.habit else { return "" }
        return trackerHabit.name
    }

    var habitIsCompleted: Bool {
        guard let trackerHabit = tracker.habit else { return false }
        return trackerHabit.isCompleted
    }

    var currentStreak: Int {
        guard let trackerHabit = tracker.habit else { return 0 }
        return trackerHabit.currentStreak
    }

    var nextMilestone: Int {
        guard let trackerHabit = tracker.habit else { return 0 }
        return trackerHabit.milestones[trackerHabit.currentMilestoneIndex]
    }

    func addHabit(name: String) {
        tracker.createHabit(name: name)
        habit = tracker.habit
    }

    func toggleReminder() {
        guard let trackerHabit = tracker.habit else { return }
        trackerHabit.isReminderOn.toggle()
        habit = trackerHabit
    }

    func markHabitAsCompleted() {
        guard let trackerHabit = tracker.habit else { return }
        trackerHabit.currentStreak += 1
        trackerHabit.isCompleted = true
        habit = trackerHabit
    }

    func nextDay() {
        tracker.today = Calendar.current.date(byAdding: .day, value: 1, to: tracker.today)!
        today = tracker.today
        tracker.newDay()
    }

}
