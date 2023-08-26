
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
        guard let _ = tracker.habit else { return false }
        return tracker.targetAchieved
    }

    var habitCreated: Bool {
        guard let habit = tracker.habit else { return false }
        return true
    }

    var isReminderOn: Bool {
        guard var trackerHabit = tracker.habit else { return false }
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
        guard var trackerHabit = tracker.habit else { return }
        trackerHabit.isReminderOn.toggle()
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
        habit = tracker.habit
        tracker.today = Calendar.current.date(byAdding: .day, value: 1, to: tracker.today)!
        today = tracker.today
    }

}
