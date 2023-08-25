
import Foundation

class Habit {
  let target: Int = 28
  let milestones: [Int] = [1, 2, 3, 5, 7, 10, 14, 21]
  let creationDate: Date = Date()
  var currentStreak: Int
  var isCompleted: Bool
  var isReminderOn: Bool

  var name: String

  var currentMilestoneIndex: Int

  var targetAchieved: Bool {
    return currentStreak == target
  }

  func newDay() {
    if !isCompleted {
      currentStreak = 0
      currentMilestoneIndex = 0
    } else {
      if currentStreak == milestones[currentMilestoneIndex] && currentMilestoneIndex + 1 < milestones.count {
        currentMilestoneIndex += 1
      }
    }
    isCompleted = false
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
    var today = Date()
    var habit: Habit? = nil

    func createHabit(name: String) {
        habit = Habit(name: name)
        print(String(describing: habit))
    }

    func deleteHabit(name: String) {
        habit = nil
    }
}
