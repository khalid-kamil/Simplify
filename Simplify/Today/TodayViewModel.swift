
import Foundation

class TodayViewModel: ObservableObject {
    @Published var tracker: Tracker
    @Published var today: Date
    @Published var habit: Habit?

    init(tracker: Tracker = Tracker()) {
        self.tracker = tracker
        self.today = tracker.today
        self.habit = tracker.habit
    }

    func addHabit(name: String) {
        tracker.createHabit(name: name)
        habit = tracker.habit
    }

}
