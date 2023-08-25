
import Foundation

class Habit {
  let target: Int = 28
  let milestones: [Int] = [1, 2, 3, 5, 7, 10, 14, 21, 28]
  let creationDate: Date = Date()
  var currentStreak: Int
  var isCompleted: Bool
  var isReminderOn: Bool

  var name: String

  var currentMilestoneIndex: Int

  var targetAchieved: Bool {
    return currentStreak == target
  }

    init(currentStreak: Int = 0, isCompleted: Bool = false, isReminderOn: Bool = false, name: String, currentMilestoneIndex: Int = 0) {
        self.currentStreak = currentStreak
        self.isCompleted = isCompleted
        self.isReminderOn = isReminderOn
        self.name = name
        self.currentMilestoneIndex = currentMilestoneIndex
    }
}

class Tracker {
    static let shared = Tracker()

    private init(today: Date = Date(), habit: Habit? = nil) {
        self.today = today
        self.habit = habit
    }

    var today: Date
    var habit: Habit?

    func createHabit(name: String) {
        habit = Habit(name: name)
        print(String(describing: habit))
    }

    func deleteHabit(name: String) {
        habit = nil
    }

    func newDay() {
        guard let habit = habit else { return }
        if !habit.isCompleted {
            habit.currentStreak = 0
            habit.currentMilestoneIndex = 0
      } else {
          if habit.currentStreak == habit.milestones[habit.currentMilestoneIndex] && habit.currentMilestoneIndex + 1 < habit.milestones.count {
              habit.currentMilestoneIndex += 1
        }
      }
        habit.isCompleted = false
    }


}
